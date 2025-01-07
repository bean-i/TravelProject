//
//  TravelInfoDetailViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/7/25.
//

import UIKit
import Kingfisher

class TravelInfoDetailViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    
    var detailImage: String?
    var detailTitle: String?
    var detailDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setData()
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    
    func setDesign() {
        navigationItem.title = "관광지 화면"
        
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        popButton.backgroundColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0)
        popButton.setTitleColor(.white, for: .normal)
        popButton.layer.cornerRadius = 20
        popButton.setTitle("다른 관광지 보러 가기", for: .normal)
        popButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
    }
    
    func setData() {
        let url = URL(string: detailImage!)
        mainImageView.kf.setImage(with: url)
        titleLabel.text = detailTitle
        descriptionLabel.text = detailDescription
    }

}
