//
//  ProductItem.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/2.
//

import Foundation

struct ProductItem: Identifiable {
    let id: UUID = UUID()
    
//    var assetId: Int = 0
    var name: LocalizedStringResource = ""
//    var isDownloaded: Bool = true
//    var isLiked: Bool = false
    var icon: String = ""
//    var assetName: String = ""
}

let allProducts: [ProductItem] = [
    .init(name: "Tropea1", icon: "floor1"),
    .init(name: "Tropea2", icon: "floor2"),
    .init(name: "Tropea3", icon: "floor3"),
    .init(name: "Tropea4", icon: "floor4"),
    .init(name: "Tropea5", icon: "floor5"),
    .init(name: "Tropea6", icon: "floor6"),
    .init(name: "Tropea7", icon: "floor7"),
    .init(name: "Tropea8", icon: "floor8"),
    .init(name: "Tropea9", icon: "floor1"),
]
