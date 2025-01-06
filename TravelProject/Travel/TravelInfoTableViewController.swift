//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/3/25.
//

import UIKit

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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    func makeAddCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoAddTableViewCell.identifier, for: indexPath) as! TravelInfoAddTableViewCell

        cell.configureData(row: travelInfo[indexPath.row])
        
        return cell
    }
    
    func makeInfoCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier, for: indexPath) as! TravelInfoTableViewCell

        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.configureData(row: travelInfo[indexPath.row], index: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelInfo[indexPath.row]
        
        if row.ad {
            return makeAddCell(tableView, indexPath)
        } else {
            return makeInfoCell(tableView, indexPath)
        }
        
    }
    
}
