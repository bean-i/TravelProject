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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopping.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.identifier, for: indexPath) as! ShoppingTableViewCell
        
        cell.configureData(row: shopping[indexPath.row])
        
        // 구매 버튼 태그, 액션
        cell.purchaseButton.tag = indexPath.row
        cell.purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        
        // 즐겨찾기 버튼 태그, 액션
        cell.starButton.tag = indexPath.row
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
