//
//  CityTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/6/25.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {

    static let identifier = "CityTableViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.backgroundColor = .black
    }
    
    func configure() {
        mainImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.textColor = .white
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        cityExplainLabel.textColor = .white
        cityExplainLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureData(row: City) {
        let url = URL(string: row.city_image)
        mainImageView.kf.setImage(with: url)
        
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cityExplainLabel.text = row.city_explain
        
    }
    
}
