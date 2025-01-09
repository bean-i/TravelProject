//
//  RestaurantMapViewController.swift
//  TravelProject
//
//  Created by 이빈 on 1/8/25.
//

import UIKit
import MapKit


class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var restaurantSegment: UISegmentedControl!
    @IBOutlet var restaurantMapView: MKMapView!
    
//    var locations: Set<(Double, Double)> = []
    
    var currentRestaurants = RestaurantList().restaurantArray {
        didSet {
//            locations.removeAll()
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
            setMapView()
        }
    }
    
    let restaurants = RestaurantList().restaurantArray
    let koreanRestaurants = RestaurantList().restaurantArray.filter { $0.category == "한식" }
    let westernRestaurants = RestaurantList().restaurantArray.filter { $0.category == "양식" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantMapView.delegate = self
        
        setMapView()
        setSegment()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        print(#function)
        let alert = UIAlertController(title: "필터", message: nil, preferredStyle: .actionSheet)
        let all = UIAlertAction(title: "전체", style: .default) {_ in 
            self.currentRestaurants = self.restaurants
        }
        let korean = UIAlertAction(title: "한식", style: .default) {_ in 
            self.currentRestaurants = self.koreanRestaurants
        }
        let western = UIAlertAction(title: "양식", style: .default) {_ in
            self.currentRestaurants = self.westernRestaurants
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(all)
        alert.addAction(korean)
        alert.addAction(western)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
    @objc func didTapSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("전체")
            currentRestaurants = restaurants
        case 1:
            print("한식")
            currentRestaurants = koreanRestaurants
        case 2:
            print("양식")
            currentRestaurants = westernRestaurants
        default:
            return
        }
    }
    
    
    func setSegment() {
        restaurantSegment.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
        
        restaurantSegment.selectedSegmentIndex = 0
        restaurantSegment.setTitle("전체", forSegmentAt: 0)
        restaurantSegment.setTitle("한식", forSegmentAt: 1)
        restaurantSegment.setTitle("양식", forSegmentAt: 2)
    }
    
    func setMapView() {
        for item in currentRestaurants {
//            var latitude = item.latitude
//            var longitude = item.longitude
            
//            let result = locations.insert(latitude).inserted
//            let result2 = locations.insert(longitude).inserted
//            
//            if !(result && result2) {
//                latitude += 0.0001
//                longitude += 0.0001
//            }
            
            let current = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = current
            annotation.title = item.name
            restaurantMapView.addAnnotation(annotation)
        }
        restaurantMapView.showAnnotations(restaurantMapView.annotations, animated: true)
    }
    
}
