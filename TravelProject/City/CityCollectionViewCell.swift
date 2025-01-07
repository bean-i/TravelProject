//
//  CityCollectionViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/7/25.
//

import UIKit
import Kingfisher

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.backgroundColor = .black
        titleLabel.text = "로드 중"
        explainLabel.text = "로드 중"
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.backgroundColor = .black
        titleLabel.text = "로드 중"
        explainLabel.text = "로드 중"
    }
    
    func configure() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 80
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        explainLabel.font = .systemFont(ofSize: 12)
        explainLabel.textColor = .gray
        explainLabel.textAlignment = .center
        explainLabel.numberOfLines = 0
    }
    
    func configureData(row: City) {
        if let url = URL(string: row.city_image) {
            mainImageView.kf.setImage(with: url)
        } else {
            mainImageView.image = UIImage(systemName: "star")
        }
        
        titleLabel.text = "\(row.city_name) | \(row.city_english_name)"
        
        explainLabel.text = row.city_explain
    }

}
