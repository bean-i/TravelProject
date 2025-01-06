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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineInfoTableViewCell.identifier, for: indexPath) as! MagazineInfoTableViewCell
        
        cell.configureData(row: magazine[indexPath.row])
        
        return cell
    }
    
}
