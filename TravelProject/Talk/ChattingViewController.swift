//
//  ChattingViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/10/25.
//

import UIKit

class ChattingViewController: UIViewController, setView {

    static let identifier = "ChattingViewController"
    
    var chatRoomName: String = ""
    var chatDetailList: [Chat] = []

    @IBOutlet var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("데이터 왔어요><")
        print(chatDetailList)
        
        setDesign()
        
    }
    
    func setDesign() {
        basicDesign()
        tableViewDesign()
    }
    
    func basicDesign() {
        navigationItem.title = chatRoomName
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
    

}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let chatData = chatDetailList else {
//            print("데이터가 없는디요..?")
//            return 0 // 이 예외처리를 다른데서 해줘야 하나..?
//        }
        
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
