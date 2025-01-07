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
        
        navigationItem.backButtonTitle = ""
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
        
        cell.configureData(row: travelInfo[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        if travelInfo[indexPath.row].ad {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TravelInfoAddDetailViewController") as! TravelInfoAddDetailViewController
            vc.detailAdd = travelInfo[indexPath.row].title
            
            let nav = UINavigationController(rootViewController: vc)
            nav.navigationBar.tintColor = .black
            
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .flipHorizontal
            
            present(nav, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TravelInfoDetailViewController") as! TravelInfoDetailViewController
            
            vc.detailImage = travelInfo[indexPath.row].travel_image
            vc.detailTitle = travelInfo[indexPath.row].title
            vc.detailDescription = travelInfo[indexPath.row].description
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
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
