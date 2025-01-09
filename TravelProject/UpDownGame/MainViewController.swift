//
//  MainViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/9/25.
//

import UIKit

class MainViewController: UIViewController, setView {
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var underLineView: UIView!
    
    @IBOutlet var gameStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberTextField.text = nil
    }
    
    func setDesign() {
        basicDesign()
        labelDesign()
        imageDesign()
        textFieldDesign()
        buttonDesign()
    }
    
    func basicDesign() {
        view.backgroundColor = .main
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func labelDesign() {
        mainTitleLabel.text = "UP DOWN"
        mainTitleLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        mainTitleLabel.textAlignment = .center
        
        subTitleLabel.text = "GAME"
        subTitleLabel.textAlignment = .center
    }
    
    func imageDesign() {
        mainImageView.image = .emotion1
        mainImageView.contentMode = .scaleAspectFill
    }

    func textFieldDesign() {
        numberTextField.delegate = self
        
        numberTextField.borderStyle = .none
        numberTextField.font = .systemFont(ofSize: 22, weight: .bold)
        numberTextField.textAlignment = .center
        numberTextField.keyboardType = .numberPad
        
        underLineView.backgroundColor = .white
    }
    
    func buttonDesign() {
        gameStartButton.backgroundColor = .black
        gameStartButton.setTitle("시작하기", for: .normal)
        gameStartButton.isEnabled = false
        gameStartButton.titleLabel?.textColor = .white
        gameStartButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        gameStartButton.tintColor = .white
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func gameStartButtonTapped(_ sender: UIButton) {
        print(#function)
        
        guard let number = numberTextField.text else {
            print("텍스트필드 오류")
            return
        }
        
        guard let userNumber = Int(number) else {
            showAlert(title: "오류", message: "숫자만 작성해 주세요.")
            return
        }
        
        if userNumber == 0 {
            showAlert(title: "숫자 범위 오류", message: "1 이상의 숫자를 작성해 주세요.")
        } else {
            // 화면 이동
            let vc = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            vc.maxNum = userNumber
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let number = textField.text else {
            print("텍스트필드 오류")
            return
        }
        
        if number.isEmpty { // 아무 값 없을 때는 버튼 터치 X
            gameStartButton.isEnabled = false
        } else {
            gameStartButton.isEnabled = true
        }
    }
    
}
