//
//  RealityViewExtensions.swift
//

import Foundation
import RealityKit
import SwiftUI

public extension RealityView {
    
    func installGestures() -> some View {
        simultaneousGesture(dragGesture)
            .simultaneousGesture(magnifyGesture)
            .simultaneousGesture(rotateGesture)
    }

    func installGestures(dragCompletion: @escaping (EntityTargetValue<DragGesture.Value>) -> Void) -> some View {
        simultaneousGesture(makeDragGesture(completion: dragCompletion))
            .simultaneousGesture(magnifyGesture)
            .simultaneousGesture(rotateGesture)
    }

    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }

    func makeDragGesture(completion: @escaping (EntityTargetValue<DragGesture.Value>) -> Void) -> some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .useGestureComponent(completion: completion)
    }

    var magnifyGesture: some Gesture {
        MagnifyGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
    
    var rotateGesture: some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
}
