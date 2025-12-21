import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @State private var rootAnchor = AnchorEntity(world: .zero)
    
    @State private var sceneAnchor1 = AnchorEntity()
    @State private var sceneAnchor2 = AnchorEntity()
    
    @State private var styleAnchor1 = AnchorEntity()
    
//    @State private var selectHomeAnchor = AnchorEntity()
//    @State private var controlPanelAnchor = AnchorEntity()
        
    @Environment(AppModel.self) private var appModel

    var body: some View {
        RealityView { content, attachments in

            content.add(rootAnchor)
            
            let skybox = createSkybox()
                        content.add(skybox!)
            
            rootAnchor.addChild(sceneAnchor1)
            sceneAnchor1.position = [-2, 0, -2.5]
            
            rootAnchor.addChild(sceneAnchor2)
            sceneAnchor2.position = [0, 0, -3.5]
            
            rootAnchor.addChild(styleAnchor1)
            styleAnchor1.position = [1, 0, -2.5]
            
//            rootAnchor.addChild(selectHomeAnchor)
//            selectHomeAnchor.position = [0, 0, -1]
            
//            rootAnchor.addChild(controlPanelAnchor)
//            controlPanelAnchor.position = [0, 0, -1]
            
            var unlitMaterial = UnlitMaterial()
            unlitMaterial.color = .init(tint: .white)
            
            if sceneAnchor1.children.isEmpty {
                let circle = ModelEntity(
                    mesh: .generatePlane(width: 0.25, depth: 0.25, cornerRadius: 0.5)
                )
                circle.model?.materials = [unlitMaterial]
                circle.position = [0, 0.03, 0]
                sceneAnchor1.addChild(circle)
                
                let cylinder = ModelEntity(
                    mesh: .generateBox(size: [0.001, 1, 0.001])
                )
                cylinder.model?.materials = [unlitMaterial]
                cylinder.position = [0, 0.5, 0]
                sceneAnchor1.addChild(cylinder)
            }

            if sceneAnchor2.children.isEmpty {
                let circle2 = ModelEntity(
                    mesh: .generatePlane(width: 0.25, depth: 0.25, cornerRadius: 0.5)
                )
                circle2.model?.materials = [unlitMaterial]
                circle2.position = [0, 0.03, 0]
                sceneAnchor2.addChild(circle2)
                
                let cylinder2 = ModelEntity(
                    mesh: .generateBox(size: [0.001, 1, 0.001])
                )
                cylinder2.model?.materials = [unlitMaterial]
                cylinder2.position = [0, 0.5, 0]
                sceneAnchor2.addChild(cylinder2)
            }

            if let immersiveContentEntity = try? await Entity(
                named: "Royalwood_1226",
                in: realityKitContentBundle
            ) {
                rootAnchor.addChild(immersiveContentEntity)
            }

            if let frosted1 = attachments.entity(for: "MyFrostedUI1") {
                frosted1.name = "MyFrostedUI1"
                frosted1.position = [0, 1.05, 0]
                sceneAnchor1.addChild(frosted1)
            }
            if let frosted2 = attachments.entity(for: "MyFrostedUI2") {
                frosted2.name = "MyFrostedUI2"
                frosted2.position = [0, 1.05, 0]
                sceneAnchor2.addChild(frosted2)
            }
            
//            if let changeStyleView = attachments.entity(for: "ChangeStyleView") {
//                changeStyleView.name = "ChangeStyleView"
//                changeStyleView.position = [0, 0.2, 0]
////                let rotation = simd_quatf(angle: .pi / 4, axis: SIMD3<Float>(-1, 0, 0))
////                changeStyleView.transform.rotation = rotation
//                styleAnchor1.addChild(changeStyleView)
//                if let whiteDotUI = attachments.entity(for: "WhiteDotUI") {
//                        whiteDotUI.name = "WhiteDotUI"
//                        whiteDotUI.position = [-0.1, -0.1, 0]
//                    whiteDotUI.isEnabled = true
//                        changeStyleView.addChild(whiteDotUI)
//                    }
//            }
            
//            if let selectView = attachments.entity(for: "VirtualHomeView") {
//                selectView.name = "VirtualHomeView"
//                selectView.position = [0, 1, 0]
//                selectHomeAnchor.addChild(selectView)
//                selectView.isEnabled = appModel.virtualHomeViewVisible
//                print("VirtualHomeView visible in immersive view: \(appModel.virtualHomeViewVisible)")
//            }
            
//            if let controlPanelView = attachments.entity(for: "ControlPanelWindow") {
//                controlPanelView.name = "ControlPanelWindow"
//                controlPanelView.position = [0, 0.7, 0]
//                let rotation = simd_quatf(angle: .pi / 4, axis: SIMD3<Float>(-1, 0, 0))
//                controlPanelView.transform.rotation = rotation
//                controlPanelAnchor.addChild(controlPanelView)
//                controlPanelView.isEnabled = appModel.showControlPanel
//            }
        }
        attachments: {
            Attachment(id: "MyFrostedUI1") {
                FrostedUI {
                    teleport(to: sceneAnchor1, others: [sceneAnchor2, styleAnchor1])
                    updateEntityOrientation()
                }
            }
            
            Attachment(id: "MyFrostedUI2") {
                FrostedUI {
                    teleport(to: sceneAnchor2, others: [sceneAnchor1, styleAnchor1])
                    updateEntityOrientation()
                }
            }
            
//            Attachment(id: "ChangeStyleView") {
//                ChangeStyleView{ isShowing in
//                    updateEntityOrientation()
//                    if let whiteDotUI = rootAnchor.findEntity(named: "WhiteDotUI") {
//                        whiteDotUI.isEnabled = !isShowing
//                    }
//                }
//            }
            
//            Attachment(id: "WhiteDotUI") {
//                WhiteDotUI{
////                    updateEntityOrientation()
//                }
//            }
            
//            Attachment(id: "VirtualHomeView") {
//                VirtualHomeView()
//            }
            
//            Attachment(id: "ControlPanelWindow") {
//                ControlPanelWindow()
//            }
        }
//        .onChange(of: appModel.virtualHomeViewVisible) { newValue in
//            print("VirtualHomeView visibility changed to: \(newValue)")
//            updateVirtualHomeViewVisibility(isVisible: newValue)
//        }
//        .onChange(of: appModel.showControlPanel) { newValue in
//            print("controlPanel visibility changed to: \(newValue)")
//            updateControlPanelVisibility(isVisible: newValue)
//        }
        .onChange(of: appModel.isClearEntitiesForRoom2) { newAsset in
            if (appModel.isClearEntitiesForRoom2 == true) {
                clearEntities()
                appModel.isClearEntitiesForRoom2 = false
            } else {
                print("no need to reset for room 2")
            }
        }
    }

    func desiredAngle(for anchor: AnchorEntity) -> Float {
        if anchor == sceneAnchor1 {
            return .pi
        } else if anchor == sceneAnchor2 {
            return -.pi
        } else {
            return 0
        }
    }
    
    func teleport(to targetAnchor: AnchorEntity, others: [AnchorEntity]) {
        let targetWorldPos = targetAnchor.position(relativeTo: nil)
        
        var oldPositions = [ObjectIdentifier: SIMD3<Float>]()
        for a in others {
            oldPositions[ObjectIdentifier(a)] = a.position(relativeTo: nil)
            print(a.position)
            print(targetAnchor.position)
        }
        
        rootAnchor.position -= targetWorldPos
        
        targetAnchor.position = .zero
        
        for a in others {
            if let oldPos = oldPositions[ObjectIdentifier(a)] {
                a.position = oldPos - targetWorldPos
            }
        }
        
//        let angle = desiredAngle(for: targetAnchor)
//
//        let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
//        rootAnchor.transform.rotation = rotation
        
    }
    
    func updateEntityOrientation() {
        if let frostedEntity = rootAnchor.findEntity(named: "MyFrostedUI1") {
            faceEntityTowardOrigin(frostedEntity)
        }
        if let frostedEntity2 = rootAnchor.findEntity(named: "MyFrostedUI2") {
            faceEntityTowardOrigin(frostedEntity2)
        }
        if let selectStyleEntity = rootAnchor.findEntity(named: "ChangeStyleView") {
            faceEntityTowardOrigin(selectStyleEntity)
//            let rotation = simd_quatf(angle: .pi / 4, axis: SIMD3<Float>(-1, 0, 0))
//            selectStyleEntity.transform.rotation = rotation
        }
//        if let selectStyleEntity2 = rootAnchor.findEntity(named: "WhiteDotUI") {
//            faceEntityTowardOrigin(selectStyleEntity2)
//        }
    }
    
    func faceEntityTowardOrigin(_ entity: Entity) {
        let worldPosition = entity.position(relativeTo: nil)
        let direction = SIMD3<Float>(-worldPosition.x, 0, -worldPosition.z)
        let dist = simd_length(direction)
        guard dist > 0.0001 else { return }
        
        let forward = simd_normalize(direction)
        let baseForward = SIMD3<Float>(0,0,1)
        let rotation = simd_quatf(from: baseForward, to: forward)
        entity.transform.rotation = rotation
    }
    
//    private func updateVirtualHomeViewVisibility(isVisible: Bool) {
//        if let selectView = rootAnchor.findEntity(named: "VirtualHomeView") {
//            selectView.isEnabled = isVisible
//        }
//    }
    
//    private func updateControlPanelVisibility(isVisible: Bool) {
//        if let selectView = rootAnchor.findEntity(named: "ControlPanelWindow") {
//            selectView.isEnabled = isVisible
//        }
//    }
    
    private func createSkybox() -> Entity? {
        let largeSphere = MeshResource.generateSphere(radius: 50)
        var skyboxMaterial = UnlitMaterial()
        
        do {
            let texture = try TextureResource.load(named: "skybox")
            skyboxMaterial.color = .init(texture: .init(texture))
        } catch {
            print("Failed to create skybox material: \(error)")
            return nil
        }
        
        let skyboxEntity = Entity()
        skyboxEntity.components.set(ModelComponent(mesh: largeSphere, materials: [skyboxMaterial]))
        
        skyboxEntity.scale = .init(x: -1, y: 1, z: 1)
        return skyboxEntity
    }
    
    private func clearEntities() {
        print("reset scene")
        resetScene()
        print("start to clean")
        rootAnchor.children.removeAll()
        sceneAnchor1.children.removeAll()
        sceneAnchor2.children.removeAll()
        styleAnchor1.children.removeAll()
//        selectHomeAnchor.children.removeAll()
//        controlPanelAnchor.children.removeAll()
        
        print("All entities removed from anchors")
    }
    
    private func resetScene() {
        rootAnchor.position = .zero
        sceneAnchor1.position = [-2, 0, -2.5]
        sceneAnchor2.position = [0, 0, -3.5]
        styleAnchor1.position = [1, 0, -2.5]
//        selectHomeAnchor.position = [0, 0, -1]
//        controlPanelAnchor.position = [0, 0, -1]
    }
}
