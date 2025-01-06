//
//  CityTableViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/6/25.
//

import UIKit

class CityTableViewController: UITableViewController {

    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    
    let allCity = CityInfo().city
    let domesticCity = CityInfo().city.filter{$0.domestic_travel == true}
    let overseasCity = CityInfo().city.filter{$0.domestic_travel == false}
    
    var city: [City] = CityInfo().city {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityTableViewCell.identifier)
        
        citySegment.selectedSegmentIndex = 0
    }
    
    @IBAction func citySegmentChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("모두")
            city = allCity
        case 1:
            print("국내")
            city = domesticCity
        case 2:
            print("해외")
            city = overseasCity
        default:
            print("오류")
            return
        }
    
    }
    
    func searchCityWithTextField() {
        // 현재 테이블 뷰의 데이터(city)에서 검색.
        guard let searchCity = searchTextField.text else {
            print("텍스트필드 오류")
            return
        }
        
        for ct in city {
            if ct.city_name == searchCity
                || ct.city_english_name == searchCity
                || ct.city_explain.contains(searchCity) {
                city = [ct]
            }
        }
    }
    
    func liveSearch() {
        
    }
    
    // 검색 기능
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
        searchCityWithTextField()
    }
    
    // 실시간 검색 기능
    @IBAction func textFieldChanged(_ sender: UITextField) {
        // 현재 텍스트 필드에 있는 단어를 포함하는 것들로 배열 새로 구성.
        guard let searchCity = searchTextField.text else {
            print("텍스트필드 오류")
            return
        }
        // 입력 값이 없으면, 기존 배열 보여주기
        if searchCity.isEmpty {
            citySegmentChanged(citySegment)
        } else { // 입력 값이 있으면, 초기화 (이후 검색)
            city = []
        }
        
        switch citySegment.selectedSegmentIndex {
        case 0:
            for ct in allCity {
                if ct.city_name.contains(searchCity)
                    || ct.city_english_name.contains(searchCity)
                    || ct.city_explain.contains(searchCity) {
                    print(ct.city_name)
                    city.append(ct)
                }
            }
        case 1:
            for ct in domesticCity {
                if ct.city_name.contains(searchCity)
                    || ct.city_english_name.contains(searchCity)
                    || ct.city_explain.contains(searchCity) {
                    print(ct.city_name)
                    city.append(ct)
                }
            }
        case 2:
            for ct in overseasCity {
                if ct.city_name.contains(searchCity)
                    || ct.city_english_name.contains(searchCity)
                    || ct.city_explain.contains(searchCity) {
                    print(ct.city_name)
                    city.append(ct)
                }
            }
        default:
            print("오류")
            return
        }
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        
        cell.configureData(row: city[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
