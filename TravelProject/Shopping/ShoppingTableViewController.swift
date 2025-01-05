//
//  ShoppingTableViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/3/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    var shopping = ShoppingInfo().shopping {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerViewDesign()
    }
    
    func headerViewDesign() {
        itemTextField.backgroundColor = .systemGray6
        itemTextField.layer.cornerRadius = 10
        itemTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        itemTextField.leftViewMode = .always
        itemTextField.placeholder = "무엇을 구매하실 건가요?"
        
        addButton.setTitle("추가", for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 10
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let newItem = Shopping(title: itemTextField.text, purchase: false, bookMark: false)
        shopping.append(newItem)
        itemTextField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        let newItem = Shopping(title: itemTextField.text, purchase: false, bookMark: false)
        shopping.append(newItem)
        itemTextField.text = ""
        view.endEditing(true)
    }
    
    @objc func purchaseButtonTapped(_ sender: UIButton) {
        shopping[sender.tag].purchase.toggle()
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        shopping[sender.tag].bookMark.toggle()
    }
    
    // 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopping.count
    }
    
    // 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        let row = shopping[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.backgroundColor = .systemGray6
        
        // 구매 완료 버튼
        cell.purchaseButton.tag = indexPath.row
        let purchaseImage = row.purchase ? "checkmark.square.fill" : "checkmark.square"
        cell.purchaseButton.setImage(UIImage(systemName: purchaseImage), for: .normal)
        cell.purchaseButton.tintColor = .black
        cell.purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        
        // 타이틀 레이블
        cell.titleLabel.text = row.title
        
        // 즐겨찾기 버튼
        cell.starButton.tag = indexPath.row
        let starButtonImage = row.bookMark ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: starButtonImage), for: .normal)
        cell.starButton.tintColor = .black
        cell.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shopping.remove(at: indexPath.row)
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
