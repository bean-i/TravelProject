//
//  CityCollectionViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/7/25.
//

import UIKit

class CityCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    var currentCity = CityInfo().city {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    var allCity = CityInfo().city
    var domesticCity = CityInfo().city.filter{$0.domestic_travel == true}
    var overseasCity = CityInfo().city.filter{$0.domestic_travel == false}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCitySegment()
        setCollectionView()
    }
    
    func setCitySegment() {
        citySegment.selectedSegmentIndex = 0
        citySegment.setTitle("모두", forSegmentAt: 0)
        citySegment.setTitle("국내", forSegmentAt: 1)
        citySegment.setTitle("해외", forSegmentAt: 2)
    }
    
    func setCollectionView() {
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 160, height: 240)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        cityCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func citySegmentTapped(_ sender: UISegmentedControl) {
        print("\(citySegment.selectedSegmentIndex)가 선택 됨.")
        switch citySegment.selectedSegmentIndex {
        case 0:
            currentCity = allCity
        case 1:
            currentCity = domesticCity
        case 2:
            currentCity = overseasCity
        default:
            print("세그먼트 오류")
            return
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as! CityCollectionViewCell
        
        cell.configureData(row: currentCity[indexPath.row])
        
        return cell
    }
    

}
