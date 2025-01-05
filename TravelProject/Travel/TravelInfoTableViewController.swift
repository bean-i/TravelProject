//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/3/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewController: UITableViewController {

    var travelInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        // nil -> true, true -> false, false -> true
        if travelInfo[sender.tag].like == nil {
            travelInfo[sender.tag].like = true
        } else {
            travelInfo[sender.tag].like!.toggle()
        }
        tableView.reloadData()
    }
    
    // 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    // 셀의 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoTableViewCell", for: indexPath) as! TravelInfoTableViewCell
        
        let row = travelInfo[indexPath.row]
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        // 타이틀 레이블
        cell.titleLabel.text = row.title
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        // 서브타이틀 레이블
        cell.subTitleLabel.text = row.description == nil ? "" : row.description!
        cell.subTitleLabel.numberOfLines = 0
        cell.subTitleLabel.font = .systemFont(ofSize: 13)
        cell.subTitleLabel.textColor = .darkGray
        
        // 별 이미지
        cell.starImageView.image = UIImage(systemName: "star.fill")
        cell.starImageView.tintColor = .systemYellow
        
        // 별점
        cell.starGrade.text = row.grade == nil ? "" :
        "(\(row.grade!)) •"
        cell.starGrade.textColor = .lightGray
        cell.starGrade.font = .systemFont(ofSize: 12)
        
        // 저장 수
        if let save = row.save {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let count = numberFormatter.string(for: save)!
            cell.saveCount.text = "저장 \(count)"
        } else {
            cell.saveCount.text = ""
        }
        cell.saveCount.textColor = .lightGray
        cell.saveCount.font = .systemFont(ofSize: 12)
        
        
        // 메인 이미지
        if let image = row.travel_image {
            let url = URL(string: image)
            cell.travelImageView.kf.setImage(with: url)
            cell.travelImageView.contentMode = .scaleAspectFill
        } else {
            cell.travelImageView.backgroundColor = .black
            cell.travelImageView.image = UIImage(systemName: "exclamationmark.icloud")
            cell.travelImageView.tintColor = .lightGray
            cell.travelImageView.contentMode = .scaleAspectFit
        }
        cell.travelImageView.layer.cornerRadius = 8
        
        // 하트
        if let heart = row.like {
            let image = heart ? "heart.fill" : "heart"
            cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
        } else {
            // 만약 nil값이 있다면, 기본 값으로
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        cell.likeButton.tintColor = .white
        
        return cell
    }
    
}
