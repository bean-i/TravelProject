//
//  TalkCollectionViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/10/25.
//

import UIKit

class TalkCollectionViewCell: UICollectionViewCell {

    static let identifier = "TalkCollectionViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var lastChatLabel: UILabel!
    @IBOutlet var lastDateLabel: UILabel!
    
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
        configure()
    }
    
    // 셀의 바뀌지 않는 디자인
    func configure() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = mainImageView.frame.width / 2
        mainImageView.backgroundColor = .white
        
        userLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        userLabel.textAlignment = .left
        
        lastChatLabel.textColor = .darkGray
        lastChatLabel.textAlignment = .left
        lastChatLabel.font = .systemFont(ofSize: 14)
        
        lastDateLabel.textColor = .gray
        lastDateLabel.textAlignment = .right
        lastDateLabel.font = .systemFont(ofSize: 12)
    }
    
    // 셀에 데이터 넣기
    func configureData(_ item: ChatRoom) {
        // 셀의 태그 설정
        tag = item.chatroomId
        
        // 메인 이미지 설정
        mainImageView.image = UIImage(named: "\(item.chatroomImage[0])")
        
        // 메인 유저 설정
        userLabel.text = item.chatroomName
        
        // 마지막 대화 레이블 설정
        lastChatLabel.text = item.chatList.last?.message
        
        // date 설정
        let originalDate = item.chatList.last?.date ?? ""
        if let date = stringToDateFormatter.date(from: originalDate) {
            let stringDate = dateToStringFormatter.string(from: date)
            lastDateLabel.text = stringDate
        } else {
            lastDateLabel.text = ""
        }
        
    }

}
