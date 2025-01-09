//
//  GameViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/9/25.
//

import UIKit

class GameViewController: UIViewController, setView {
    
    var maxNum: Int = 0 // 사용자가 입력한 최대 숫자
    lazy var correctNum: Int = Int.random(in: 1...maxNum) // 정답 숫자
    var userSelectNumber: Int = 0 // 사용자가 컬렉션뷰에서 선택한 숫자
    
    lazy var gameNums: [Int] = Array(1...maxNum) { // 게임 숫자 배열
        didSet {
            numberCollectionView.reloadData()
        }
    }
    
    var tryCount: Int = 0 { // 시도 횟수
        didSet {
            subTitleLabel.text = "시도 횟수: \(tryCount)"
        }
    }
    
    var maxSelectCellCount: Int = 0
    
    // 게임 진행 시, gameNums 배열을 재설정할 때 사용할 시작 인덱스와 마지막 인덱스
    var startIndex: Int = 1
    lazy var lastIndex: Int = maxNum
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var numberCollectionView: UICollectionView!
    @IBOutlet var getResultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("정답: ", correctNum)
        setDesign()
    }

    func setDesign() {
        basicDesign()
        labelDesign()
        buttonDesign()
        collectionViewDesign()
    }
    
    func basicDesign() {
        view.backgroundColor = .main
    }
    
    func labelDesign() {
        mainTitleLabel.text = "UP DOWN"
        mainTitleLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        mainTitleLabel.textAlignment = .center
        
        subTitleLabel.text = "시도 횟수: \(tryCount)"
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = .systemFont(ofSize: 18)
    }
    
    func buttonDesign() {
        getResultButton.setTitle("결과 확인하기", for: .normal)
        
        // 컬렉션뷰에서 숫자 안 고르면 터치 안 먹게
        getResultButton.isEnabled = false //fasle->gray, true->black
        getResultButton.backgroundColor = .gray
        getResultButton.titleLabel?.textColor = .white
        getResultButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        getResultButton.tintColor = .white
    }
    
    func collectionViewDesign() {
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
        
        let xib = UINib(nibName: NumberCollectionViewCell.identifier, bundle: nil)
        numberCollectionView.register(xib, forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
        
        let cellCount: CGFloat = 5
        let inset: CGFloat = 10
        let spacing: CGFloat = 10
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let totalCellWidth = deviceWidth - (inset * 2) - (spacing * (cellCount - 1))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.itemSize = CGSize(width: totalCellWidth / cellCount, height: totalCellWidth / cellCount)
        
        numberCollectionView.collectionViewLayout = layout
        numberCollectionView.backgroundColor = .none
    }
    
    func selectCell(_ cell: NumberCollectionViewCell, at: Int) {
        cell.circleView.backgroundColor = .black
        cell.numberLabel.textColor = .white
        cell.select = true
        userSelectNumber = startIndex + at
//        userSelectNumber = Int(cell.numberLabel.text!)!
        getResultButton.backgroundColor = .black
        getResultButton.isEnabled = true
    }
    
    func deselectCell(_ cell: NumberCollectionViewCell) {
        cell.circleView.backgroundColor = .white
        cell.numberLabel.textColor = .black
        cell.select = false
        userSelectNumber = 0 // 사용자 값 초기화
        getResultButton.backgroundColor = .gray
        getResultButton.isEnabled = false
    }
    
    @IBAction func getResultButtonTapped(_ sender: UIButton) {
        print(#function)
        
        tryCount += 1
        // 답 계산하는 로직 + 컬렉션 뷰 업데이트 + 메인에 결과 보여주기 + 횟수 계산
        if userSelectNumber < correctNum { // Up
            startIndex = userSelectNumber + 1
            mainTitleLabel.text = "UP"
        } else if userSelectNumber > correctNum { // Down
            lastIndex = userSelectNumber - 1
            mainTitleLabel.text = "DOWN"
        } else {
            mainTitleLabel.text = "GOOD!"
            return
        }
        gameNums = Array(startIndex...lastIndex)
        print("업데이트: ", gameNums)
        maxSelectCellCount -= 1
    }

}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameNums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.identifier, for: indexPath) as! NumberCollectionViewCell

        cell.circleView.backgroundColor = .white
        cell.numberLabel.textColor = .black
        cell.numberLabel.text = String(gameNums[indexPath.item])
        cell.select = false

        DispatchQueue.main.async {
            cell.circleView.layer.cornerRadius = cell.circleView.frame.width / 2
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        let cell = collectionView.cellForItem(at: indexPath) as! NumberCollectionViewCell
        
        // 중복 터치 방지
        if maxSelectCellCount == 0 { // 터치 가능
            maxSelectCellCount += 1
            selectCell(cell, at: indexPath.item)
        } else if cell.select { // 선택한 셀의 개수가 1이상인데, 그게 나 자신이라면
            maxSelectCellCount -= 1
            deselectCell(cell)
        }
        print("선택된 셀의 개수: ", maxSelectCellCount)
        print(userSelectNumber)
        
    }
    
}
