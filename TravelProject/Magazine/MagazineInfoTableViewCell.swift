//
//  MagazineInfoTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/3/25.
//

import UIKit

class MagazineInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MagazineInfoTableViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
//    var dateFormat: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyMMdd"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        
//        if let date = dateFormatter.date(from: dateLabel.text ?? "") {
//            dateFormatter.dateFormat = "yy년 M월 d일"
//            let stringDate = dateFormatter.string(from: date)
//            return stringDate
//        } else {
//            return dateLabel.text ?? ""
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        // 메인 이미지
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        
        // 메인 타이틀
        mainTitleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        mainTitleLabel.numberOfLines = 0
        
        // 서브 타이틀
        subTitleLabel.font = .systemFont(ofSize: 14)
        subTitleLabel.textColor = .darkGray
        subTitleLabel.numberOfLines = 0
        
        // 날짜 레이블
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .lightGray
    }
    
    func configureData(row: Magazine) {
        // 이미지 등록
        if let url = URL(string: row.photo_image) {
            mainImageView.kf.setImage(with: url)
        } else {
            mainImageView.image = UIImage(systemName: "arrow.down.app.dashed.trianglebadge.exclamationmark")
        }
        
        // 메인타이틀 설정
        mainTitleLabel.text = row.title
        
        // 서브타이틀 설정
        subTitleLabel.text = row.subtitle
        
        // date 설정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: row.date) {
            dateFormatter.dateFormat = "yy년 M월 d일"
            let stringDate = dateFormatter.string(from: date)
            dateLabel.text = stringDate
            print(dateFormatter.string(from: date))
        } else {
            dateLabel.text = row.date
            print("오류")
        }
        
    }
    
}
