//
//  NumberCollectionViewCell.swift
//  TravelProject
//
//  Created by 이빈 on 1/9/25.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NumberCollectionViewCell"
    var select = false
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var circleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    

}
