//
//  outgoingTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/10/25.
//

import UIKit

class outgoingTableViewCell: UITableViewCell {
    
    static let identifier = "outgoingTableViewCell"
    
    @IBOutlet var outgoingBubbleView: UIView!
    @IBOutlet var outgoingMessageLabel: UILabel!
    @IBOutlet var outgoingDateLabel: UILabel!
    
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
        
        outgoingMessageLabel.numberOfLines = 0
        outgoingMessageLabel.textAlignment = .left
        outgoingMessageLabel.font = .systemFont(ofSize: 14)
        
        outgoingBubbleView.backgroundColor = .systemGray5
        outgoingBubbleView.layer.borderColor = UIColor.gray.cgColor
        outgoingBubbleView.layer.borderWidth = 1
        outgoingBubbleView.layer.cornerRadius = 10
        
        outgoingDateLabel.textColor = .gray
        outgoingDateLabel.textAlignment = .right
        outgoingDateLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureData(_ row: Chat) {
        // 보낸 채팅 내용
        outgoingMessageLabel.text = row.message
        
        // date 설정
        if let date = stringToDateFormatter.date(from: row.date) {
            let stringDate = dateToStringFormatter.string(from: date)
            outgoingDateLabel.text = stringDate
        } else {
            outgoingDateLabel.text = ""
        }
    }
    
}
