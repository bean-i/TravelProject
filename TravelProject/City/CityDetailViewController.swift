//
//  CityDetailViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/7/25.
//

import UIKit
import Kingfisher

class CityDetailViewController: UIViewController {
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    var mainImage: String?
    var cityName: String?
    var cityEngName: String?
    var cityExplain: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setData()
    }
    
    func setDesign() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        
        cityNameLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        cityNameLabel.textAlignment = .left
        cityNameLabel.numberOfLines = 0
        
        cityExplainLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        cityExplainLabel.textAlignment = .left
        cityExplainLabel.numberOfLines = 0
    }
    
    func setData() {
        if let url = URL(string: mainImage!) {
            mainImageView.kf.setImage(with: url)
        } else {
            mainImageView.backgroundColor = .black
        }
//        cityNameLabel.text = cityName // 그냥 넣을 때는 오류가 안 나는데, 문자열 보간법을 쓸 때 오류가 나는 이유,,
        cityNameLabel.text = "\(cityName ?? "") | \(cityEngName ?? "")"
        cityExplainLabel.text = cityExplain
    }
    

}
