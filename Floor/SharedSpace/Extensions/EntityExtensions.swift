//
//  EntityExtensions.swift
//

import Foundation
import RealityKit

public extension SIMD3 where Scalar == Float {
    static let up = SIMD3<Float>(x: 0, y: 1, z: 0)
    var magnitude: Float {
        return simd_length(self)
    }
}

public extension Entity {
    var gestureComponent: GestureComponent? {
        get { components[GestureComponent.self] }
        set { components[GestureComponent.self] = newValue }
    }
    var scenePosition: SIMD3<Float> {
        get { position(relativeTo: nil) }
        set { setPosition(newValue, relativeTo: nil) }
    }
    var sceneOrientation: simd_quatf {
        get { orientation(relativeTo: nil) }
        set { setOrientation(newValue, relativeTo: nil) }
    }
}

