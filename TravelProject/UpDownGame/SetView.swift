//
//  SetView.swift
//  TravelProject
//
//  Created by 이빈 on 1/9/25.
//

import Foundation

@objc protocol setView {
    func setDesign()
    @objc optional func basicDesign()
    @objc optional func labelDesign()
    @objc optional func imageDesign()
    @objc optional func textFieldDesign()
    @objc optional func buttonDesign()
    @objc optional func collectionViewDesign()
}
