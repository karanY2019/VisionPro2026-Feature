//
//  Products.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/22.
//

import Foundation

enum ProductType: String, Codable {
    case floor
    case stairs
    case door
    case cabinet
    
    var name: String {
        switch self {
            case .floor:
                return "Floor"
            case .stairs:
                return "Stairs"
            case .door:
                return "Door"
            case .cabinet:
                return "Cabinet"
        }
    }
}

struct ProductListResponse: Codable {
    var productList: [Product] = []
}

struct Product: Codable {
    var productId: Int
    var type: ProductType
    var title: String
    var description: String
}

struct ItemListResponse: Codable {
    var itemList: [PItem] = []
}

struct PItem: Codable {
    var productId: Int
    var type: ProductType
    var items: [PItemDetail] = []
}

struct PItemDetail: Identifiable, Codable {
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnailUrl: String = ""
    var images: [PItemDetailImageInfo] = []
    var asset: String = ""
    var materials: [String: String] = [:]
    var Specs: [PItemDetailModuleInfo] = []
}

struct PItemDetailImageInfo: Codable {
    var order: Int
    var url: String
}

struct PItemDetailModuleInfo: Codable {
    var module: String
    var icon: String
    var order: Int
    var subs: [PItemDetailModuleSub]
}

struct PItemDetailModuleSub: Codable {
    var name: String
    var desc: String
    var position: Int
}

// General Item
struct PGeneralItemInfo: Codable {
    var productId: Int
    var itemId: Int
    
    func toJsonString() -> String? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding PGeneralItemInfo to JSON: \(error)")
            return nil
        }
    }
    
    static func fromJsonString(_ jsonString: String) -> PGeneralItemInfo? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error converting JSON string to data")
            return nil
        }
        
        do {
            let itemInfo = try JSONDecoder().decode(PGeneralItemInfo.self, from: jsonData)
            return itemInfo
        } catch {
            print("Error decoding PGeneralItemInfo from JSON: \(error)")
            return nil
        }
    }
}

// Favorite Item
struct PFavoriteItemInfo: Codable {
    var favoriteData: FavoriteResponse.FavoriteData
    var detailInfo: PItemDetail
    
    // 默认初始化方法
    init(favoriteData: FavoriteResponse.FavoriteData = FavoriteResponse.FavoriteData.defaultValue(), detailInfo: PItemDetail = PItemDetail()) {
        self.favoriteData = favoriteData
        self.detailInfo = detailInfo
    }
}

/*
"specs":
    {
        "species": "European Oak",
        "grade": "ABC",
        "coreNBack": "Hardwood Plywood",
        "edges": "Micro-beveled"
        "finish": "UV Lacquer",
        "treatment": "Smoked",
        "texture": "Wire Brushed",
        "profiling": "Tongue & Groove, with four side bevel , 1.2mm bevel on long-sides + 0.2mm bevel on short sides.",
        "adhesive": "Top layer lamination: Formaldehyde - Free.\nProduct contains No Added Urea Formaldehyde (NAUF).\nCARB ATCM Phase II Compliant ( < 0.05 PPM Formaldehyde)",
        "length": "86-5/8 with 25% two strips per carton",
        "topLayerThickness": "4mm",
        "thickness": "18mm",
        "plankWidth": "8-5/8",
        "dimensionsImage": "floor_F06EL_dimensions.jpeg"
    }
*/

/*
 {
     "productId": 2,
     "type": "cabinet",
     "items": []
 },
 {
     "productId": 3,
     "type": "stairs",
     "items": []
 },
 {
     "productId": 4,
     "type": "door",
     "items": []
 },
 */
