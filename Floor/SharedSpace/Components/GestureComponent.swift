//
//  GestureComponent.swift
//

import RealityKit
import SwiftUI

public class EntityGestureState {
    var targetedEntity: Entity?
    // MARK: - Drag
    var dragStartPosition: SIMD3<Float> = .zero
    var isDragging = false
    var pivotEntity: Entity?
    var initialOrientation: simd_quatf?
    // MARK: - Magnify
    var startScale: SIMD3<Float> = .one
    var isScaling = false
    // MARK: - Rotation
    var startOrientation = Rotation3D.identity
    var isRotating = false
    static let shared = EntityGestureState()
    var onlyRotateOnXAxis: Bool = false
    var onlyRotateOnYAxis: Bool = false
    var onlyRotateOnZAxis: Bool = false
}

public struct GestureComponent: Component, Codable {
    
    public static func make(canDrag: Bool = false, pivotOnDrag: Bool = false, preserveOrientationOnPivotDrag: Bool = false, canScale: Bool = false, canRotate: Bool = false) -> GestureComponent {
        return GestureComponent(
            canDrag: canDrag,
            pivotOnDrag: pivotOnDrag,
            preserveOrientationOnPivotDrag: preserveOrientationOnPivotDrag,
            canScale: canScale,
            canRotate: canRotate)
    }

    init(canDrag: Bool, pivotOnDrag: Bool, preserveOrientationOnPivotDrag: Bool, canScale: Bool, canRotate: Bool) {
        self.canDrag = canDrag
        self.pivotOnDrag = pivotOnDrag
        self.preserveOrientationOnPivotDrag = preserveOrientationOnPivotDrag
        self.canScale = canScale
        self.canRotate = canRotate
    }

    public var canDrag: Bool = true
    public var pivotOnDrag: Bool = true
    public var preserveOrientationOnPivotDrag: Bool = true
    public var canScale: Bool = true
    public var canRotate: Bool = true
    
    // MARK: - Drag Logic
    mutating func onChanged(value: EntityTargetValue<DragGesture.Value>) {
        guard canDrag else { return }
//        print("EntityTargetValue<DragGesture.Value>: onChanged...")
        let state = EntityGestureState.shared
        if state.targetedEntity == nil {
            state.targetedEntity = value.entity
            state.initialOrientation = value.entity.orientation(relativeTo: nil)
        }
        if pivotOnDrag {
            handlePivotDrag(value: value)
        } else {
            handleFixedDrag(value: value)
        }
    }
    
    mutating private func handlePivotDrag(value: EntityTargetValue<DragGesture.Value>) {
        
        let state = EntityGestureState.shared
        guard let entity = state.targetedEntity else { fatalError("Gesture contained no entity") }
        var targetPivotTransform = Transform()
        if let inputDevicePose = value.inputDevicePose3D {
            targetPivotTransform.scale = .one
            targetPivotTransform.translation = value.convert(inputDevicePose.position, from: .local, to: .scene)
            targetPivotTransform.rotation = value.convert(AffineTransform3D(rotation: inputDevicePose.rotation), from: .local, to: .scene).rotation
        } else {
            targetPivotTransform.translation = value.convert(value.location3D, from: .local, to: .scene)
        }
        
        if !state.isDragging {
            let pivotEntity = Entity()
            guard let parent = entity.parent else { fatalError("Non-root entity is missing a parent.") }
            parent.addChild(pivotEntity)
            pivotEntity.move(to: targetPivotTransform, relativeTo: nil)
            pivotEntity.addChild(entity, preservingWorldTransform: true)
            state.pivotEntity = pivotEntity
            state.isDragging = true
        } else {
            state.pivotEntity?.move(to: targetPivotTransform, relativeTo: nil, duration: 0.2)
        }
        if preserveOrientationOnPivotDrag, let initialOrientation = state.initialOrientation {
            state.targetedEntity?.setOrientation(initialOrientation, relativeTo: nil)
        }
    }
    
    mutating private func handleFixedDrag(value: EntityTargetValue<DragGesture.Value>) {
        let state = EntityGestureState.shared
        guard let entity = state.targetedEntity else { fatalError("Gesture contained no entity") }
        
        if !state.isDragging {
            state.isDragging = true
            state.dragStartPosition = entity.scenePosition
        }
   
        let translation3D = value.convert(value.gestureValue.translation3D, from: .local, to: .scene)
        let offset = SIMD3<Float>(x: Float(translation3D.x),
                                  y: Float(translation3D.y),
                                  z: Float(translation3D.z))
        entity.scenePosition = state.dragStartPosition + offset
        if let initialOrientation = state.initialOrientation {
            state.targetedEntity?.setOrientation(initialOrientation, relativeTo: nil)
        }
        
        // debug
        let parentPos = state.targetedEntity?.parent?.position
        let targetPos = state.targetedEntity?.position
//        print("GestureComponent: targetPos \(targetPos), parentPos \(parentPos)")
    }
    
    mutating func onEnded(value: EntityTargetValue<DragGesture.Value>) {
        let state = EntityGestureState.shared
        state.isDragging = false
        
        if let pivotEntity = state.pivotEntity,
           pivotOnDrag {
            pivotEntity.parent!.addChild(state.targetedEntity!, preservingWorldTransform: true)
            pivotEntity.removeFromParent()
        }
        
        state.pivotEntity = nil
        state.targetedEntity = nil
    }

    // MARK: - Magnify Logic
    mutating func onChanged(value: EntityTargetValue<MagnifyGesture.Value>) {
        let state = EntityGestureState.shared
        guard canScale, !state.isDragging else { return }
        
        let entity = value.entity
        if !state.isScaling {
            state.isScaling = true
            state.startScale = entity.scale
        }
        let magnification = Float(value.magnification)
        // only scale x/y, not scale z
//        entity.scale = state.startScale * magnification
        entity.scale = [state.startScale.x * magnification, state.startScale.y * magnification, 1]
        
        let minScale: Float = 0.5
        let maxScale: Float = 1.5
        if entity.scale.x <= minScale { entity.scale = [minScale, minScale, 1] }
        if entity.scale.x >= maxScale { entity.scale = [maxScale, maxScale, 1] }
        
        // debug
        let parentScale = state.targetedEntity?.parent?.scale
        let targetScale = state.targetedEntity?.scale
//        print("GestureComponent: targetScale \(targetScale), parentScale \(parentScale), magnification \(magnification)")
    }
    
    mutating func onEnded(value: EntityTargetValue<MagnifyGesture.Value>) {
        EntityGestureState.shared.isScaling = false
    }
    
    // MARK: - Rotate Logic
    mutating func onChanged(value: EntityTargetValue<RotateGesture3D.Value>) {
        let state = EntityGestureState.shared
        guard canRotate, !state.isDragging else { return }
        let entity = value.entity
        if !state.isRotating {
            state.isRotating = true
            state.startOrientation = .init(entity.orientation(relativeTo: nil))
        }
        let rotation = value.rotation
        
        var newOrientation = Rotation3D.identity
        
        if state.onlyRotateOnXAxis {
            // Restrict rotation to X-axis only
            let rotateDiff = Rotation3D(angle: rotation.angle, axis: .x)
            newOrientation = state.startOrientation.rotated(by: rotateDiff)
        } else if state.onlyRotateOnYAxis {
            // Restrict rotation to Y-axis only
//            let rotateDiff = Rotation3D(angle: rotation.angle, axis: .y)
//            newOrientation = state.startOrientation.rotated(by: rotateDiff)
            let rotationAxis = RotationAxis3D(x: 0, y: 1, z: 0)
            let angle = Angle2D(radians: rotation.angle.radians * Double(sign(rotation.axis.y)))
            let rotateDiff = Rotation3D(angle: angle, axis: rotationAxis)
            newOrientation = state.startOrientation.rotated(by: rotateDiff)
        } else if state.onlyRotateOnZAxis {
            // Restrict rotation to Z-axis only
            let rotateDiff = Rotation3D(angle: rotation.angle, axis: .z)
            newOrientation = state.startOrientation.rotated(by: rotateDiff)
        } else {
            let flippedRotation = Rotation3D(angle: rotation.angle,
                                             axis: RotationAxis3D(x: -rotation.axis.x,
                                                                  y: rotation.axis.y,
                                                                  z: -rotation.axis.z))
            newOrientation = state.startOrientation.rotated(by: flippedRotation)
        }
        entity.setOrientation(.init(newOrientation), relativeTo: nil)
    }
    
    mutating func onEnded(value: EntityTargetValue<RotateGesture3D.Value>) {
        EntityGestureState.shared.isRotating = false
    }
}
