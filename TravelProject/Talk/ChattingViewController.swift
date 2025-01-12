//
//  ChattingViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/10/25.
//

import UIKit

class ChattingViewController: UIViewController, setView {

    static let identifier = "ChattingViewController"
    var lastIndex: IndexPath = IndexPath()
    
    var chatRoomName: String = ""
    var chatDetailList: [Chat] = []

    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chatTableView.scrollToRow(at: lastIndex, at: .bottom, animated: false)
    }
    
    func setDesign() {
        basicDesign()
        textFieldDesign()
        tableViewDesign()
    }
    
    func basicDesign() {
        navigationItem.title = chatRoomName
    }
    
    func textFieldDesign() {
        textView.delegate = self
        textView.backgroundColor = .lightGray
        textView.text = "메시지를 입력하세요"
    }
    
    func tableViewDesign() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.separatorStyle = .none
        
        let incomingXib = UINib(nibName: incomingTableViewCell.identifier, bundle: nil)
        chatTableView.register(incomingXib, forCellReuseIdentifier: incomingTableViewCell.identifier)
        
        let outgoingXib = UINib(nibName: outgoingTableViewCell.identifier, bundle: nil)
        chatTableView.register(outgoingXib, forCellReuseIdentifier: outgoingTableViewCell.identifier)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 여기서 user가 나인지 아닌지 판단하고
        // 그거에따라 셀 두개 중에 하나 골라서 보여주기.
        let row = chatDetailList[indexPath.row]
        
        if row.user == User.user {
            print("나야...")
            let outgoingCell = tableView.dequeueReusableCell(withIdentifier: outgoingTableViewCell.identifier, for: indexPath) as! outgoingTableViewCell
            
            outgoingCell.configureData(row)
            
            return outgoingCell
            
        } else {
            let incomingCell = tableView.dequeueReusableCell(withIdentifier: incomingTableViewCell.identifier, for: indexPath) as! incomingTableViewCell
            
            incomingCell.configureData(row)

            return incomingCell
        }

    }
    
}

extension ChattingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
}
