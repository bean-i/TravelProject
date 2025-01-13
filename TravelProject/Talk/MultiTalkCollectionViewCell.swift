//
//  MultiTalkCollectionViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/12/25.
//

import UIKit

class MultiTalkCollectionViewCell: UICollectionViewCell {

    @IBOutlet var user1ImageView: UIImageView!
    @IBOutlet var user2ImageView: UIImageView!
    @IBOutlet var user3ImageView: UIImageView!
    @IBOutlet var user4ImageView: UIImageView!
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var lastMessageLabel: UILabel!
    
    var stringToDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    var dateToStringFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure() {
        user1ImageView.contentMode = .scaleAspectFill
        user1ImageView.layer.cornerRadius = user1ImageView.frame.width / 2
        user1ImageView.backgroundColor = .white
        
        user2ImageView.contentMode = .scaleAspectFill
        user2ImageView.layer.cornerRadius = user2ImageView.frame.width / 2
        user2ImageView.backgroundColor = .white
        
        user3ImageView.contentMode = .scaleAspectFill
        user3ImageView.layer.cornerRadius = user3ImageView.frame.width / 2
        user3ImageView.backgroundColor = .white
        
        user4ImageView.contentMode = .scaleAspectFill
        user4ImageView.layer.cornerRadius = user4ImageView.frame.width / 2
        user4ImageView.backgroundColor = .white
        
        userName.font = .systemFont(ofSize: 16, weight: .semibold)
        userName.textAlignment = .left
        
        lastMessageLabel.textColor = .darkGray
        lastMessageLabel.textAlignment = .left
        lastMessageLabel.font = .systemFont(ofSize: 14)
        
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
        dateLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureData(_ item: ChatRoom) {
        // 셀의 태그 설정
        tag = item.chatroomId
        
        // 이미지 설정
        user1ImageView.image = UIImage(named: "\(item.chatroomImage[0])")
        user2ImageView.image = UIImage(named: "\(item.chatroomImage[1])")
        user3ImageView.image = UIImage(named: "\(item.chatroomImage[2])")
        user4ImageView.image = UIImage(named: "\(item.chatroomImage[3])")
        
        // 메인 유저 설정
        userName.text = item.chatroomName
        
        // 마지막 대화 레이블 설정
        lastMessageLabel.text = item.chatList.last?.message
        
        // date 설정
        let originalDate = item.chatList.last?.date ?? ""
        if let date = stringToDateFormatter.date(from: originalDate) {
            let stringDate = dateToStringFormatter.string(from: date)
            dateLabel.text = stringDate
        } else {
            dateLabel.text = ""
        }
    }
    
    
    

}
