//
//  GestureExtensions.swift
//

import Foundation
import RealityKit
import SwiftUI

// MARK: - Rotate
public extension Gesture where Value == EntityTargetValue<RotateGesture3D.Value> {
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onChanged(value: value)
            value.entity.components.set(gestureComponent)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
            value.entity.components.set(gestureComponent)
        }
    }
}

// MARK: - Drag
public extension Gesture where Value == EntityTargetValue<DragGesture.Value> {
    func useGestureComponent(completion: @escaping (_ChangedGesture<Self>.Value) -> Void = {_ in }) -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onChanged(value: value)
            value.entity.components.set(gestureComponent)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
            value.entity.components.set(gestureComponent)
            completion(value)
        }
    }
}

// MARK: - Magnify
public extension Gesture where Value == EntityTargetValue<MagnifyGesture.Value> {
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onChanged(value: value)
            value.entity.components.set(gestureComponent)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
            value.entity.components.set(gestureComponent)
        }
    }
}

