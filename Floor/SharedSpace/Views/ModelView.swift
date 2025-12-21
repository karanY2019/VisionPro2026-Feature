//
//  ModelView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/10.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelView: View {
    @State private var scale: Float = 0.1
    @State private var rotationAngle: Float = 0
    @State private var yPosition: Float = 1.2
    
    @State private var movable: Bool = true
    @State private var rotatable: Bool = false
    @State private var scalable: Bool = false
    
    @Environment(AppModel.self) private var appModel

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State private var floorEntity: Entity? = nil
    @State private var floorModelEntity: Entity? = nil
    
    @State private var modelPos: SIMD3<Float> = [0, 0, 0]
    @State private var modelScale: SIMD3<Float> = [1, 1, 1]
    @State private var modelRotation: simd_quatf = .init()
    @State private var modelAnchor = AnchorEntity()
    
    var body: some View {
        
        RealityView { content, attachments in
//            let box = ModelEntity(mesh: .generateBox(size: 0.1))
            let box = ModelEntity(mesh: .generateBox(width: 0.6, height: 1, depth: 0.005))
            box.model?.materials = [SimpleMaterial(color: .red, isMetallic: false)]
            box.isEnabled = true
            box.position = [1, 1.5, -1.5]
                
            box.setScale([0.5, 0.5, 0.5], relativeTo: nil)
            
            box.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            box.generateCollisionShapes(recursive: true)
            box.components.set(GestureComponent.make(canDrag: true, pivotOnDrag: false, preserveOrientationOnPivotDrag: false, canScale: false, canRotate: true))
//            content.add(box)
            
            // PinkBox
            if let pinkBox = try? await Entity(named: "Floor3", in: realityKitContentBundle) {
                pinkBox.position = [1, 1.5, -1]
                pinkBox.components.set(InputTargetComponent(allowedInputTypes: .indirect))
                pinkBox.setScale([0.1, 0.1, 0.1], relativeTo: nil)
                pinkBox.generateCollisionShapes(recursive: true)
//                pinkBox.orientation = simd_quatf(angle: rotationAngle, axis: [1, 0, 0])
                if let boxModel = pinkBox.findEntity(named: "Plane_020") {
                    if let boxModel2 = boxModel as? ModelEntity {
                        boxModel2.components.set(GestureComponent.make(canDrag: true, pivotOnDrag: false, preserveOrientationOnPivotDrag: false, canScale: false, canRotate: true))
                    }
                }
//                content.add(pinkBox)
            }
            
            // Bologna Novara9 Palermo-B Floor3
            if let floorEntity = try? await Entity(named: appModel.currentDetailItem?.asset ?? "Bologna_B", in: realityKitContentBundle) {
                floorEntity.position = [0, 0.4, -2.2]
//                floorEntity.setScale([0.5, 0.5, 0.5], relativeTo: nil)
                floorEntity.orientation = simd_quatf(angle: rotationAngle, axis: [1, 0, 0])
                setupComps(floorEntity)
                content.add(floorEntity)
                self.floorEntity = floorEntity
                print("ModelView: floorEntityPos \(floorEntity.position), modelEntityPos \(floorModelEntity?.position)")
                print("ModelView: floorEntityScale \(floorEntity.scale), modelEntityScale \(floorModelEntity?.scale)")
                print("ModelView: floorEntityRotation \(floorEntity.orientation), modelEntityRotation \(floorModelEntity?.orientation)")
            }
            
            if let controlsAttachment = attachments.entity(for: "Controls") {
                // 将控制面板添加到内容根节点，而不是 floorModelEntity
                content.add(controlsAttachment)
                
                // 设置正确的朝向
                controlsAttachment.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
                
                // 设置在视野中可见的位置
                if let floorModelPos = floorModelEntity?.position {
                    controlsAttachment.position = [floorModelPos.x, floorModelPos.y - 0.7, floorModelPos.z + 0.5]
                } else {
                    controlsAttachment.position = [0, 0.4, -1.7]
                }
                
                // 确保控制面板可见
                print("ModelView: Adding controlsAttachment at position \(controlsAttachment.position)")
            }
        } update: { content, attachments in
            // 在这里更新 controlsAttachment 的位置，使其跟随 floorEntity 的移动
            if let controlsAttachment = attachments.entity(for: "Controls"),
               let floorModelPos = self.floorModelEntity?.position {
                // 只更新位置，保持自身的旋转和缩放不变
                controlsAttachment.position = [floorModelPos.x, floorModelPos.y - 0.7, floorModelPos.z + 0.5]
            }
        } attachments: {
            Attachment(id: "Controls") {
//                controlsView
                controlsView2
            }
        }
        .installGestures()
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                // Handle drag gesture
            }
    }
    
    private func setupComps(_ entity: Entity) {
        guard let skeletonEntity = entity.findEntity(named: "Floor") else { // Plane_020
            print("ModelView: skeletonEntity not found, asset name: \(entity.name)")
            return
        }
        guard let modelEntity = skeletonEntity as? ModelEntity else {
            print("ModelView: skeletonEntity can not convert to model entity, asset name: \(entity.name)")
            return
        }
        
        // 创建红色 cube
        let cube = ModelEntity(
            mesh: .generateBox(size: 0.2),  // 增大尺寸使其更容易看到
            materials: [SimpleMaterial(color: .red, isMetallic: false)]
        )
        cube.position = [0, 1, 0]  // 在 modelEntity 上方 1 米处
        
        // 将 cube 添加为 modelEntity 的子实体
//        modelEntity.addChild(cube)
        
        entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        entity.generateCollisionShapes(recursive: true)
        
//        modelEntity.components.set(GestureComponent.make(canDrag: true, pivotOnDrag: false, preserveOrientationOnPivotDrag: false, canScale: true, canRotate: true))
//        
//        self.floorModelEntity = modelEntity
        
        entity.components.set(GestureComponent.make(canDrag: true, pivotOnDrag: false, preserveOrientationOnPivotDrag: false, canScale: true, canRotate: true))
        
        self.floorModelEntity = entity
        
    }
    
    private var controlsView : some View {
        HStack(spacing: 40) {
            // Position Control
            VStack {
                Toggle(isOn: $movable) {
                    Text("Move")
                }
                .foregroundColor(.white)
                .frame(width: 120)
                .onChange(of: movable) { newValue, oldValue in
                    enableMove(movable)
                }
            }
            // Rotation Control
            VStack {
                Toggle(isOn: $rotatable) {
                    Text("Rotate")
                }
                .foregroundColor(.white)
                .frame(width: 120)
                .onChange(of: rotatable) { newValue, oldValue in
                    enableRotate(rotatable)
                }
            }
            // Scale Control
            VStack {
                Toggle(isOn: $scalable) {
                    Text("Scale")
                }
                .foregroundColor(.white)
                .frame(width: 120)
                .onChange(of: scalable) { newValue, oldValue in
                    enableScale(scalable)
                }
            }
            // Reset Button
            Button(action: {
                floorModelEntity?.position = [0, 0, 0]
                floorModelEntity?.scale = [1, 1, 1]
                floorModelEntity?.orientation = simd_quatf(angle: 0, axis: [1, 0, 0])
            }) {
                Text("Reset")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            // Exit Button
            Button(action: {
                Task { @MainActor in
                    if appModel.modelFullSpaceState == .open {
                        appModel.modelFullSpaceState = .inTransition
                        await dismissImmersiveSpace()
                    }
                }
            }) {
                Text("Exit")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .cornerRadius(8)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .glassBackgroundEffect()
    }
    
    private var controlsView2 : some View {
        HStack(spacing: 20) {
            // Exit Button
            Button(action: {
                Task { @MainActor in
                    if appModel.modelFullSpaceState == .open {
                        appModel.modelFullSpaceState = .inTransition
                        await dismissImmersiveSpace()
                    }
                }
            }) {
                Image(systemName: "xmark")
                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            
            Divider()
            
            // Reset Button
            Button(action: {
                floorModelEntity?.position = [0, 0, 0]
                floorModelEntity?.scale = [1, 1, 1]
                floorModelEntity?.orientation = simd_quatf(angle: 0, axis: [1, 0, 0])
            }) {
                Text("1:1")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 10)
//                    .cornerRadius(8)
            }
            
            // Measure Btn
            Button(action: {
                
            }) {
                Image(systemName: "ruler")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .glassBackgroundEffect()
        .frame(minWidth: 300, maxWidth: 400, minHeight: 60, maxHeight: 80)
    }
}

extension ModelView {
    // Update
    func enableMove(_ enable: Bool = true) {
        if var gestureComponent = floorModelEntity?.components[GestureComponent.self]  {
            gestureComponent.canDrag = enable
            floorModelEntity?.components.set(gestureComponent)
        }
    }
    func enableScale(_ enable: Bool = true) {
        if var gestureComponent = floorModelEntity?.components[GestureComponent.self]  {
            gestureComponent.canScale = enable
            floorModelEntity?.components.set(gestureComponent)
        }
    }
    func enableRotate(_ enable: Bool = true) {
        if var gestureComponent = floorModelEntity?.components[GestureComponent.self]  {
            gestureComponent.canRotate = enable
            floorModelEntity?.components.set(gestureComponent)
        }
    }
    // Reset
}

#Preview(immersionStyle: .full) {
    ModelView()
        .environment(AppModel())
}
