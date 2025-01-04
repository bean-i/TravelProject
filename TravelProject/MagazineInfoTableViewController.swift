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
        
        // 그 전에 지금 어디 셀인지?! 알아야지!!
        let row = magazine[indexPath.row]
        
        // 이미지 등록
//        cell.mainImageView.image = row.photo_image
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
    
    // 3. 셀의 높이
    // 셀의 높이를 동적으로 주고 싶어서, 셀 안의 뷰들의 레이아웃을 설정하면 자동으로 인식 될 줄 알았어요..
    // 근데 셀 안에 uiview를 새로 넣고 그 안에 원래 있던 뷰들을 넣고 레이아웃을 설정하니까 셀의 높이가 자동으로 설정이 됐는데, 왜 이렇게 되는건가요..?
    // uiview의 bottom을 컨텐트뷰의 bottom이랑 같게하고, uiview 안의 마지막 레이블의 bottom을 uiview와 10의 간격을 가지도록 설정해놔야 적용이 됩니다..
    // 이 조건을 둘다 사용할 때만, 셀의 높이가 동적으로 설정되는데 왜 둘 다 적용해야하는지 모르겠어요!!!!
    
    // 그리고 레이블은 왜 yposition 오류가 나죠?!? label은 intrinsic content라서 높이를 설정해주지 않아도 괜찮지 않나요??
}
