//
//  NumberGameViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/8/25.
//

import UIKit

class NumberGameViewController: UIViewController {
    
    @IBOutlet var gameLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var gameResultTextView: UITextView!
    @IBOutlet var resultLabel: UILabel!
    
    let numberPickerView = UIPickerView()
    let maxNum: Int = 100
    var resultNums: String = "" //텍스트뷰에 보여줄 문자열
    var resultCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        
        numberTextField.delegate = self
        
        numberPickerView.delegate = self
        numberPickerView.dataSource = self
    }
    
    func setDesign() {
        gameLabel.text = "369 게임"
        gameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        
        numberTextField.placeholder = "최대 숫자를 입력해 주세요"
        numberTextField.font = .systemFont(ofSize: 18)
        numberTextField.textAlignment = .center
        numberTextField.layer.borderColor = UIColor.darkGray.cgColor
        numberTextField.layer.borderWidth = 1
        
        gameResultTextView.text = ""
        gameResultTextView.font = .systemFont(ofSize: 18)
        gameResultTextView.textColor = .lightGray
        gameResultTextView.textAlignment = .center
        gameResultTextView.isEditable = false
        
        resultLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.text = "숫자를 입력해 보세요"
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 3단계
//    func filterNumber(_ numbers: [String]) -> [String] {
//        var nums = numbers
//        
//        for idx in 0..<numbers.count {
//            if nums[idx].contains("3") || nums[idx].contains("6") || nums[idx].contains("9") {
//                nums[idx] = "👏"
//            }
//        }
//        
//        return nums
//    }
    
    // 4단계
    func filterNumber(_ numbers: [String]) -> [String] {
        var nums = numbers
        var cnt = 0
        for idx in 0..<numbers.count {
//            cnt += nums[idx].filter{ $0 == "3" }.count
//            cnt += nums[idx].filter{ $0 == "6" }.count
//            cnt += nums[idx].filter{ $0 == "9" }.count
//            print(nums[idx])
            var newString = ""
            for char in nums[idx] {
                if char == "3" || char == "6" || char == "9" {
                    newString += "👏"
                    cnt += 1
                } else {
                    newString += String(char)
                }
            }
            nums[idx] = newString
        }
        
        resultCount = cnt
        
        return nums
    }

}

extension NumberGameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxNum
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(maxNum - row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // 현재 선택한 데이터
        let selectedNum = maxNum - row
        
        // 현재 선택한 데이터를 텍스트필드에 보여주기
        numberTextField.text = String(selectedNum)
        
        // 1부터 지금 선택한 숫자까지 텍스트뷰에 보여주기
        var strNums = Array(1...selectedNum).map{ String($0) }
        // 3단계
        strNums = filterNumber(strNums)
        resultNums = strNums.joined(separator: " ")
        
        gameResultTextView.text = resultNums
        // 4단계
        resultLabel.text = "숫자 \(selectedNum)까지 총 박수는 \(resultCount)번 입니다."
    }
    
}

extension NumberGameViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        numberTextField.inputView = numberPickerView
        return true
    }
}
