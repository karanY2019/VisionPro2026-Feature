import SwiftUI
import CoreGraphics

/// Cabinet material definition for WhiteMatte and other cabinet styles
struct CabinetMaterial: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let color: CGColor
    let texture: String?
    let roughness: Float
    let metallic: Float
    
    static let `default` = CabinetMaterial(
        name: "Default",
        color: CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0),
        texture: nil,
        roughness: 0.5,
        metallic: 0.0
    )
    
    static let whiteMatte = CabinetMaterial(
        name: "White Matte",
        color: CGColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0),
        texture: nil,
        roughness: 0.8,
        metallic: 0.0
    )
    
    static let woodGrain = CabinetMaterial(
        name: "Wood Grain",
        color: CGColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0),
        texture: "wood_grain",
        roughness: 0.6,
        metallic: 0.0
    )
    
    static let darkWalnut = CabinetMaterial(
        name: "Dark Walnut",
        color: CGColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1.0),
        texture: "dark_wood",
        roughness: 0.7,
        metallic: 0.0
    )
    
    static let grayModern = CabinetMaterial(
        name: "Gray Modern",
        color: CGColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0),
        texture: nil,
        roughness: 0.4,
        metallic: 0.0
    )
}

// Notification names for cabinet material changes
extension Notification.Name {
    static let cabinetMaterialChanged = Notification.Name("cabinetMaterialChanged")
}
