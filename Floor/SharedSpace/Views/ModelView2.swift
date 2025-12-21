//
//  ModelView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/10.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelView2: View {
    
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State private var gestureManager: SpatialGestureManager = SpatialGestures.createManager(
        referenceAnchor: Entity(), 
        isDebugEnabled: true
    )
    
    @State private var defaultFloorPosition: SIMD3<Float> = SIMD3<Float>(-0.2, 1.0, -1.3)
    @State private var floorPosition: SIMD3<Float> = SIMD3<Float>(-0.2, 1.0, -1.3)
    @State private var controlPanelOffset: SIMD3<Float> = SIMD3<Float>(0, -0.2, 0.6)
    @State private var defaultControlPanelPosition: SIMD3<Float> = SIMD3<Float>(-0.2,0.8, -0.7)
    @State private var defaultFloorScale: Float = 0.008
    @State private var hasCreatedEntity: Bool = false
    
    let basicEntity = Entity()
    
    var currentEntityName: String {
        appModel.currentDetailItem?.asset ?? "Bologna"
    }
    
    var body: some View {
        RealityView { content, attachments in
            content.entities.removeAll()
            
            content.add(basicEntity)
            if let controlPanel = attachments.entity(for: "Controls") {
                controlPanel.position = defaultControlPanelPosition
                controlPanel.name = "controlPanel"
                controlPanel.components.set(BillboardComponent())
                
                basicEntity.addChild(controlPanel)
                print("init: add control panel to scene.")
            }
            
            Task {
                do {
                    if !hasCreatedEntity {
                        let floorEntity = try await Entity(named: currentEntityName, in: realityKitContentBundle)
                        await gestureManager.addEntity(floorEntity, name: currentEntityName)
                        basicEntity.addChild(floorEntity)
                        
                        floorEntity.position = defaultFloorPosition
                        floorEntity.scale = SIMD3<Float>(repeating: defaultFloorScale)
                        
                        gestureManager.setGestureCallback { gestureInfo in
                            if gestureInfo.entityName == currentEntityName {
                                Task { @MainActor in
                                    floorPosition = gestureInfo.transform.translation
                                }
                            }
                        }
                        
                        hasCreatedEntity = true
                        print("Created new entity: \(currentEntityName)")
                    } else {
                        print("Entity already created, skipping creation")
                    }
                } catch {
                    print("ModelView2: execute task failed: \(error)")
                }
            }
        } update: { content, attachments in
            if let controlAttachment = attachments.entity(for: "Controls") {
                let newPosition = SIMD3<Float>(floorPosition.x + controlPanelOffset.x, floorPosition.y + controlPanelOffset.y, floorPosition.z + controlPanelOffset.z)
                controlAttachment.position = newPosition
            }
        } attachments: {
            Attachment(id: "Controls") {
                controlsView2
            }
        }
        .withSpatialGestures(manager: gestureManager)
        .onDisappear {
            // 埋点：离开 ModelView
            let username = appModel.userData?.username ?? "idle"
            let productName = appModel.currentDetailItem?.name
            TrackEvents.modelViewExit.record(username: username, pagePath: "modelView", productName: productName)

            if let entity = gestureManager.getEntity(named: currentEntityName)?.entity {
                entity.removeFromParent()
            }
            
            gestureManager.removeEntity(named: currentEntityName)
            
            hasCreatedEntity = false
            
            gestureManager = SpatialGestures.createManager(
                referenceAnchor: Entity(), 
                isDebugEnabled: true
            )
            
            print("ModelView2: Cleaned up on disappear")
        }
        .onAppear {
            // 埋点：进入 ModelView
            let username = appModel.userData?.username ?? "idle"
            let productName = appModel.currentDetailItem?.name
            TrackEvents.modelViewEnter.record(username: username, pagePath: "modelView", productName: productName)
            
            print("ModelView2: Appeared with entity name: \(currentEntityName)")
        }
    }

    private var controlsView2 : some View {
        HStack(spacing: 20) {
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
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            
            Divider()
            
            Button(action: {
                Task {
                    if let floorEntity = gestureManager.getEntity(named: currentEntityName)?.entity {
                        floorEntity.orientation = simd_quatf()
                        floorEntity.scale = SIMD3<Float>(repeating: defaultFloorScale)
                        floorEntity.position = defaultFloorPosition
                        
                        floorPosition = defaultFloorPosition
                    }
                }
            }) {
                Text("1:1")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            
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

#Preview(immersionStyle: .full) {
    ModelView2()
        .environment(AppModel())
}
