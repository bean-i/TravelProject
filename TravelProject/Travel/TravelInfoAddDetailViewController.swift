//
//  TravelInfoAddDetailViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/7/25.
//

import UIKit

class TravelInfoAddDetailViewController: UIViewController {

    @IBOutlet var addLabel: UILabel!
    
    var detailAdd: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setData()
    }
    
    @objc func dismissButtonTapped() {
        print(#function)
        dismiss(animated: true)
    }
    
    func setDesign() {
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        
        addLabel.font = .systemFont(ofSize: 28, weight: .bold)
        addLabel.textAlignment = .center
        addLabel.numberOfLines = 0
    }
    
    func setData() {
        addLabel.text = detailAdd
    }

}
