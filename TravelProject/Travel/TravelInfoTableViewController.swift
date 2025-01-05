//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/3/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewController: UITableViewController {

    var travelInfo = TravelInfo().travel
    let addInfo = AddInfo().add
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        // nil -> true, true -> false, false -> true
        if travelInfo[sender.tag].like == nil {
            travelInfo[sender.tag].like = true
        } else {
            travelInfo[sender.tag].like!.toggle()
        }
        tableView.reloadData()
    }
    
    // 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    func makeAddCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoAddTableViewCell", for: indexPath) as! TravelInfoAddTableViewCell
        // 광고 정보에서 랜덤으로 뽑아서 보여주기 -> 광고가 중복으로 계속 뜰 수 있음
        let index = Int.random(in: 0..<addInfo.count)
        
        // 광고 셀의 경우, indexPath.row가 4의 배수만 들어오기 때문에, 광고 배열의 길이에 맞추기 위헤 4 나누기 -> 광고 정보와 매거진 정보의 개수를 항상 맞춰주어야 함 (매거진 정보의 개수가 너무 많을 경우, 매거진행/4에 해당하는 광고 정보가 없을 수 있음)
//        let index = indexPath.row/4
        
        let row = addInfo[index]
        
        cell.selectionStyle = .none
        
        // 광고 배경
        cell.addView.layer.cornerRadius = 10
        cell.addView.backgroundColor = row.bgColor
        
        // 광고 타이틀
        cell.addTitle.text = row.title
        cell.addTitle.font = .systemFont(ofSize: 16, weight: .heavy)
        cell.addTitle.numberOfLines = 0
        cell.addTitle.textAlignment = .center
        
        // 광고 사인
        cell.addSign.backgroundColor = .white
        cell.addSign.clipsToBounds = true
        cell.addSign.layer.cornerRadius = 10
        cell.addSign.textAlignment = .center
        cell.addSign.text = "AD"
        cell.addSign.font = .systemFont(ofSize: 12)
        
        return cell
    }
    
    func makeInfoCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoTableViewCell", for: indexPath) as! TravelInfoTableViewCell
        
        let row = travelInfo[indexPath.row]
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        // 타이틀 레이블
        cell.titleLabel.text = row.title
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        // 서브타이틀 레이블
        cell.subTitleLabel.text = row.description == nil ? "" : row.description!
        cell.subTitleLabel.numberOfLines = 0
        cell.subTitleLabel.font = .systemFont(ofSize: 13)
        cell.subTitleLabel.textColor = .darkGray
        
        // 별 이미지
        cell.starImageView.image = UIImage(systemName: "star.fill")
        cell.starImageView.tintColor = .systemYellow
        
        // 별점
        cell.starGrade.text = row.grade == nil ? "" :
        "(\(row.grade!)) •"
        cell.starGrade.textColor = .lightGray
        cell.starGrade.font = .systemFont(ofSize: 12)
        
        // 저장 수
        if let save = row.save {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let count = numberFormatter.string(for: save)!
            cell.saveCount.text = "저장 \(count)"
        } else {
            cell.saveCount.text = ""
        }
        cell.saveCount.textColor = .lightGray
        cell.saveCount.font = .systemFont(ofSize: 12)
        
        
        // 메인 이미지
        if let image = row.travel_image {
            let url = URL(string: image)
            cell.travelImageView.kf.setImage(with: url)
            cell.travelImageView.contentMode = .scaleAspectFill
        } else {
            cell.travelImageView.backgroundColor = .black
            cell.travelImageView.image = UIImage(systemName: "exclamationmark.icloud")
            cell.travelImageView.tintColor = .lightGray
            cell.travelImageView.contentMode = .scaleAspectFit
        }
        cell.travelImageView.layer.cornerRadius = 8
        
        // 하트
        if let heart = row.like {
            let image = heart ? "heart.fill" : "heart"
            cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
        } else {
            // 만약 nil값이 있다면, 기본 값으로
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        cell.likeButton.tintColor = .white
        
        return cell
    }
    
    // 셀의 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 4번째 행마다 광고 넣기
        // 광고 넣을 행 계산
        let addRow = indexPath.row % 4
        
        switch addRow {
        case 0: // 광고 셀
            return makeAddCell(tableView, indexPath)
        default: // 보통 셀
            return makeInfoCell(tableView, indexPath)
        }
    }
    
}
