//
//  ShoppingTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/4/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingTableViewCell"

    @IBOutlet var cellView: UIView!
    @IBOutlet var purchaseButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    func configure() {
        selectionStyle = .none
        
        // 뷰의 배경
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = .systemGray6
        
        // 구매 완료 버튼
        purchaseButton.tintColor = .black
        
        // 즐겨찾기 버튼
        starButton.tintColor = .black
    }
    
    func configureData(row: Shopping) {
        // 구매 완료 버튼
        let purchaseImage = row.purchase ? "checkmark.square.fill" : "checkmark.square"
        purchaseButton.setImage(UIImage(systemName: purchaseImage), for: .normal)
        
        // 타이틀 레이블
        titleLabel.text = row.title
        
        // 즐겨찾기 버튼
        let starButtonImage = row.bookMark ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: starButtonImage), for: .normal)
    }
    
}
