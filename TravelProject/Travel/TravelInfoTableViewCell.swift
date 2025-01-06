//
//  TravelInfoTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/4/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewCell: UITableViewCell {

    static let identifier = "TravelInfoTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var starGrade: UILabel!
    @IBOutlet var saveCount: UILabel!
    
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        travelImageView.backgroundColor = .black
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        subTitleLabel.text = ""
        travelImageView.image = UIImage(systemName: "tray.and.arrow.down")
        starGrade.text = ""
        saveCount.text = ""
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
    }
    
    func configure() {
        // 타이틀
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        // 서브 타이틀
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .darkGray
        
        // 별 이미지
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .systemYellow
        
        // 별점
        starGrade.textColor = .lightGray
        starGrade.font = .systemFont(ofSize: 12)
        
        // 저장 수
        saveCount.textColor = .lightGray
        saveCount.font = .systemFont(ofSize: 12)
        
        // 메인 이미지
        travelImageView.layer.cornerRadius = 8
        
        // 하트
        likeButton.tintColor = .white
    }
    
    func configureData(row: Travel) {
        // 타이틀 레이블
        titleLabel.text = row.title
        
        // 서브타이틀 레이블
        subTitleLabel.text = row.description == nil ? "" : row.description!
        
        // 별점
        starGrade.text = row.grade == nil ? "" :
        "(\(row.grade!)) •"
        
        // 저장 수
        if let save = row.save {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let count = numberFormatter.string(for: save)!
            saveCount.text = "저장 \(count)"
        } else {
            saveCount.text = ""
        }
        
        // 메인 이미지
        if let image = row.travel_image {
            let url = URL(string: image)
            travelImageView.kf.setImage(with: url)
            travelImageView.contentMode = .scaleAspectFill
        } else {
            travelImageView.backgroundColor = .black
            travelImageView.image = UIImage(systemName: "exclamationmark.icloud")
            travelImageView.tintColor = .lightGray
            travelImageView.contentMode = .scaleAspectFit
        }
        
        // 하트
        if let heart = row.like {
            let image = heart ? "heart.fill" : "heart"
            likeButton.setImage(UIImage(systemName: image), for: .normal)
        } else {
            // 만약 nil값이 있다면, 기본 값으로
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
}
