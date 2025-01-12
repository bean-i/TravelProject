//
//  incomingTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/10/25.
//

import UIKit

class incomingTableViewCell: UITableViewCell {
    
    static let identifier = "incomingTableViewCell"

    @IBOutlet var incomingUserImageView: UIImageView!
    @IBOutlet var incomingUserLabel: UILabel!
    
    @IBOutlet var incomingBubbleView: UIView!
    @IBOutlet var incomingMessageLabel: UILabel!
    
    @IBOutlet var incomingDateLabel: UILabel!
    
    var stringToDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    var dateToStringFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        self.selectionStyle = .none
        
        incomingUserImageView.layer.cornerRadius = incomingUserImageView.frame.width / 2
        incomingUserImageView.backgroundColor = .white
        
        incomingUserLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        incomingUserLabel.textAlignment = .left
        
        incomingMessageLabel.numberOfLines = 0
        incomingMessageLabel.textAlignment = .left
        incomingMessageLabel.font = .systemFont(ofSize: 14)
        
        incomingBubbleView.backgroundColor = .white
        incomingBubbleView.layer.borderColor = UIColor.gray.cgColor
        incomingBubbleView.layer.borderWidth = 1
//        cell.incomingBubbleView.layer.cornerRadius = cell.incomingBubbleView.frame.height / 10
        incomingBubbleView.layer.cornerRadius = 10
        
        incomingDateLabel.textColor = .gray
        incomingDateLabel.textAlignment = .right
        incomingDateLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureData(_ row: Chat) {
        // 수신 이미지
        incomingUserImageView.image = UIImage(named: "\(row.user.profileImage)")
        
        // 수신자 이름
        incomingUserLabel.text = row.user.rawValue
        
        // 수신 채팅 내용
        incomingMessageLabel.text = row.message
        
        // date 설정
        if let date = stringToDateFormatter.date(from: row.date) {
            let stringDate = dateToStringFormatter.string(from: date)
            incomingDateLabel.text = stringDate
        } else {
            incomingDateLabel.text = ""
        }
        
    }
    
    
}
