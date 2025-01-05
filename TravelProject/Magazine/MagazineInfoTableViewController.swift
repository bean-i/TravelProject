//
//  MagazineInfoTableViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/3/25.
//

import UIKit
import Kingfisher

class MagazineInfoTableViewController: UITableViewController {
    
    let magazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1. 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    
    // 2. 셀의 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineInfoTableViewCell", for: indexPath) as! MagazineInfoTableViewCell

        let row = magazine[indexPath.row]
        
        // 이미지 등록
        if let url = URL(string: row.photo_image) {
            cell.mainImageView.kf.setImage(with: url)
        } else {
            cell.mainImageView.image = UIImage(systemName: "arrow.down.app.dashed.trianglebadge.exclamationmark")
        }
        
        cell.mainImageView.contentMode = .scaleAspectFill
        cell.mainImageView.layer.cornerRadius = 10
        
        // 메인타이틀 설정
        cell.mainTitleLabel.text = row.title
        cell.mainTitleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        cell.mainTitleLabel.numberOfLines = 0
        
        // 서브타이틀 설정
        cell.subTitleLabel.text = row.subtitle
        cell.subTitleLabel.font = .systemFont(ofSize: 14)
        cell.subTitleLabel.textColor = .darkGray
        cell.subTitleLabel.numberOfLines = 0
        
        // 데이트 설정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: row.date) {
            dateFormatter.dateFormat = "yy년 M월 d일"
            let stringDate = dateFormatter.string(from: date)
            cell.dateLabel.text = stringDate
            print(dateFormatter.string(from: date))
        } else {
            cell.dateLabel.text = row.date
            print("오류")
        }
        
        cell.dateLabel.font = .systemFont(ofSize: 13)
        cell.dateLabel.textColor = .lightGray
        
        return cell
    }
    
}
