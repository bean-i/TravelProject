//
//  TravelInfoAddTableViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/5/25.
//

import UIKit

class TravelInfoAddTableViewCell: UITableViewCell {

    static let identifier = "TravelInfoAddTableViewCell"
    
    @IBOutlet var addView: UIView!
    @IBOutlet var addTitle: UILabel!
    @IBOutlet var addSign: UILabel!
    
    let bgColor: [UIColor] = [
        UIColor(red: 0.93, green: 0.75, blue: 0.77, alpha: 1.0),
        UIColor(red: 0.68, green: 0.85, blue: 0.93, alpha: 1.0),
        UIColor(red: 0.84, green: 0.93, blue: 0.75, alpha: 1.0),
        UIColor(red: 0.98, green: 0.92, blue: 0.74, alpha: 1.0),
        UIColor(red: 0.87, green: 0.81, blue: 0.99, alpha: 1.0),
        UIColor(red: 0.96, green: 0.83, blue: 0.88, alpha: 1.0)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure() {
        selectionStyle = .none
        
        // 광고 배경
        addView.layer.cornerRadius = 10
        
        // 광고 타이틀
        addTitle.font = .systemFont(ofSize: 16, weight: .heavy)
        addTitle.numberOfLines = 0
        addTitle.textAlignment = .center
        
        // 광고 사인
        addSign.backgroundColor = .white
        addSign.clipsToBounds = true
        addSign.layer.cornerRadius = 10
        addSign.textAlignment = .center
        addSign.text = "AD"
        addSign.font = .systemFont(ofSize: 12)
    }
    
    func configureData(row: Travel) {
        // 광고 배경
        addView.backgroundColor = bgColor.randomElement() ?? .blue
        
        // 광고 타이틀
        addTitle.text = row.title
    }
    
}
