//
//  ColorLoader.swift
//  Floor
//
//  Created by Scuuu on 2025/5/25.
//

import SwiftUI

struct PaintColor: Codable, Identifiable, Equatable {
    var id: String { colorID }
    let colorName: String
    let colorID: String
    let hex: String

    enum CodingKeys: String, CodingKey {
        case colorName = "Color Name"
        case colorID = "Color ID"
        case hex = "HEX"
    }
}

typealias ColorCardData = [String: [PaintColor]]

func loadEmeraldDesignerColors() -> ColorCardData? {
    guard let url = Bundle.main.url(forResource: "EmeraldDesignerColors", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let decoded = try? JSONDecoder().decode(ColorCardData.self, from: data) else {
        return nil
    }
    return decoded
}

func loadColorSnapColors() -> [PaintColor] {
    guard let url = Bundle.main.url(forResource: "ColorSnapColors", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let decoded = try? JSONDecoder().decode([PaintColor].self, from: data) else {
        print("❌ Failed to load ColorSnapColors.json")
        return []
    }
    return decoded
}
