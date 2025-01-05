//
//  ShoppingInfo.swift
//  TravelProject
//
//  Created by 이빈 on 1/4/25.
//

import Foundation

struct Shopping {
    let title: String?
    var purchase: Bool
    var bookMark: Bool
}

struct ShoppingInfo {
    let shopping: [Shopping] = [
        Shopping(title: "맥북 사고 싶다", purchase: false, bookMark: true),
        Shopping(title: "비전 프로", purchase: true, bookMark: false),
        Shopping(title: "아이폰", purchase: false, bookMark: false),
        Shopping(title: "애플 워치", purchase: true, bookMark: true),
        Shopping(title: "백팩", purchase: false, bookMark: true)
    ]
}
