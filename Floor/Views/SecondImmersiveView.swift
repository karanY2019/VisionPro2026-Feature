//
//  SecondImmersiveView.swift
//  Floor
//
//  Created by scu on 2025/1/15.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SecondImmersiveView: View {
    @State private var rootAnchor = AnchorEntity(world: .zero)
    @State private var floorEntity: Entity? = nil
    @State private var wallEntity: Entity? = nil
    
    @State private var sceneAnchor1 = AnchorEntity()
    @State private var sceneAnchor2 = AnchorEntity()
    
    @State private var styleAnchor1 = AnchorEntity()
//    @State private var styleAnchor2 = AnchorEntity()
    
    //    @State private var selectHomeAnchor = AnchorEntity()
    //    @State private var controlPanelAnchor = AnchorEntity()
    
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        RealityView { content, attachments in
            content.add(rootAnchor)
            
//            let lightAnchor = AnchorEntity(world: .zero)
//            content.add(lightAnchor)
//            addPointLight(to: rootAnchor)
            
            let skybox = createSkybox()
            content.add(skybox!)
            
            rootAnchor.addChild(sceneAnchor1)
            sceneAnchor1.position = [-1.5, 0, -2.5]
            
            rootAnchor.addChild(sceneAnchor2)
            sceneAnchor2.position = [2, 0, -3.5]
            
            rootAnchor.addChild(styleAnchor1)
            styleAnchor1.position = [0.5, 0, -2.5]
            
//            rootAnchor.addChild(styleAnchor2)
//            styleAnchor2.position = [1.5, 0, -2]
            
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
            
            if let houseEntity = try? await Entity(
                named: "House0912",
                in: realityKitContentBundle
            ) {
                houseEntity.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
                houseEntity.name = "houseEntity"
                rootAnchor.addChild(houseEntity)
            }
            
            if let furnitureEntity = try? await Entity(
                named: "Furnitures",
                in: realityKitContentBundle
            ) {
                furnitureEntity.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
                furnitureEntity.name = "furnitureEntity"
                furnitureEntity.isEnabled = !appModel.isHideFurniture
                rootAnchor.addChild(furnitureEntity)
            }
            
            //            addPointLight()
            
            Task {
                do {
                    let scene = try await Entity(named: "HexChangeWallColor", in: realityKitContentBundle)
                    scene.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
                    scene.transform.scale = SIMD3<Float>(repeating: 100)
                    rootAnchor.addChild(scene)
//                    printEntityNames(in: scene)
                    if let rootWall = findEntityRecursively(named: "Wall525", in: scene) {
                        if let area = findEntityRecursively(named: "Wall", in: rootWall) {
                            if let wall = findEntityRecursively(named: "model_005", in: area) {
                                print("💡 Found Plan_016 entity: \(wall.name)")
                                if let model = wall.components[ModelComponent.self] {
                                    print("💡 Has ModelComponent: YES")
                                    
                                    for (i, m) in model.materials.enumerated() {
                                        print("Material \(i): \(type(of: m))")
                                    }
                                    
                                    if var shader = model.materials.last as? ShaderGraphMaterial {
                                        print("💡 Material is ShaderGraphMaterial, applying color...")
                                        if let selectedColor = appModel.currentSelectedColor,
                                           let color = hexToCGColor(selectedColor.hex) {
                                            try shader.setParameter(name: "wallColor", value: .color(color))
                                        } else {
                                            print("⚠️ 无法应用颜色：未选中颜色或 Hex 无效，currentSelectedColor为： \(appModel.currentSelectedColor)")
                                        }
                                        var newModel = model
                                        newModel.materials[model.materials.count - 1] = shader
                                        wall.components.set(newModel)
                                        print("Shader updated")
                                    } else {
                                        print("Can't find ShaderGraphMaterial")
                                    }
                                } else {
                                    print("Entity has no ModelComponent")
                                }
                            } else {
                                print("Can't find Plan_016")
                            }
                        } else {
                            print("Can't find area_01")
                        }
                    }
                    applySelectedWallColor()
                } catch {
                    print("RealityKit 加载失败: \(error)")
                }
            }
//            
            loadFloorModel()
//            loadWallModel()
            
            //            if let wallEntity = try? await Entity(
            //                named: "Wall_A",
            //                in: realityKitContentBundle
            //            ) {
            //                wallEntity.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
            //                wallEntity.name = "wallEntity"
            //                rootAnchor.addChild(wallEntity)
            //            }
            
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
            
            if let changeStyleView = attachments.entity(for: "ChangeStyleView") {
                changeStyleView.name = "ChangeStyleView"
                changeStyleView.position = [0, 0.3, 0]
                //                let rotation = simd_quatf(angle: .pi / 4, axis: SIMD3<Float>(-1, 0, 0))
                //                changeStyleView.transform.rotation = rotation
                styleAnchor1.addChild(changeStyleView)
                if let whiteDotUI = attachments.entity(for: "WhiteDotUI") {
                    whiteDotUI.name = "WhiteDotUI"
                    whiteDotUI.position = [0, -0.1, 0]
                    whiteDotUI.isEnabled = true
                    changeStyleView.addChild(whiteDotUI)
                }
            }
            
//            if let changeWallView = attachments.entity(for: "changeWallView") {
//                changeWallView.name = "changeWallView"
//                changeWallView.position = [0, 0.2, 0]
//                //                let rotation = simd_quatf(angle: .pi / 4, axis: SIMD3<Float>(-1, 0, 0))
//                //                changeStyleView.transform.rotation = rotation
//                styleAnchor2.addChild(changeWallView)
//                if let whiteDotUIForWall = attachments.entity(for: "whiteDotUIForWall") {
//                    whiteDotUIForWall.name = "whiteDotUIForWall"
//                    whiteDotUIForWall.position = [0, -0.1, 0]
//                    whiteDotUIForWall.isEnabled = true
//                    changeWallView.addChild(whiteDotUIForWall)
//                }
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
                    // 埋点
                    let username = appModel.userData?.username ?? "idle"
                    TrackEvents.immersiveSpaceMove.record(
                        username: username,
                        pagePath: "immersive_space",
                        trackData: ["target": "sceneAnchor1"]
                    )
                    
                    teleport(to: sceneAnchor1, others: [sceneAnchor2, styleAnchor1])
                    updateEntityOrientation()
                }
            }
            
            Attachment(id: "MyFrostedUI2") {
                FrostedUI {
                    // 埋点
                    let username = appModel.userData?.username ?? "idle"
                    TrackEvents.immersiveSpaceMove.record(
                        username: username,
                        pagePath: "immersive_space",
                        trackData: ["target": "sceneAnchor2"]
                    )
                    
                    teleport(to: sceneAnchor2, others: [sceneAnchor1, styleAnchor1])
                    updateEntityOrientation()
                }
            }
            
            Attachment(id: "ChangeStyleView") {
                ChangeStyleView{ isShowing in
                    // 埋点
                    let username = appModel.userData?.username ?? "idle"
                    TrackEvents.immersiveSpaceSelectFloor.record(
                        username: username,
                        pagePath: "immersive_space"
                    )
                    
                    updateEntityOrientation()
                    if let whiteDotUI = rootAnchor.findEntity(named: "WhiteDotUI") {
                        whiteDotUI.isEnabled = !isShowing
                    }
                }
                .glassBackgroundEffect(displayMode: .always)
            }
            
//            Attachment(id: "changeWallView") {
//                ChangeWallView{ isShowing in
//                    updateEntityOrientation()
//                    if let whiteDotUIForWall = rootAnchor.findEntity(named: "whiteDotUIForWall") {
//                        whiteDotUIForWall.isEnabled = !isShowing
//                    }
//                }
//                .glassBackgroundEffect(displayMode: .always)
//            }
            
            Attachment(id: "WhiteDotUI") {
                WhiteDotUI{
                    //                    updateEntityOrientation()
                }
            }
            
//            Attachment(id: "whiteDotUIForWall") {
//                WhiteDotUI{
//                    //                    updateEntityOrientation()
//                }
//            }
            
            //            Attachment(id: "VirtualHomeView") {
            //                VirtualHomeView()
            //            }
            
            //            Attachment(id: "ControlPanelWindow") {
            //                ControlPanelWindow()
            //                .glassBackgroundEffect(displayMode: .always)
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
        .onChange(of: appModel.currentDetailItem?.name) { newAsset in
            loadFloorModel()
        }
//        .onChange(of: appModel.selectedWall) { newAsset in
//            loadWallModel()
//        }
        .onChange(of: appModel.isClearEntities) { newAsset in
            if (appModel.isClearEntities == true) {
                clearEntities()
                appModel.isClearEntities = false
            } else {
                print("no need to reset for room 1")
            }
        }
        .onChange(of: appModel.currentSelectedColor) { newColor in
            print("🎨 Detected wall color change to: \(newColor?.colorName ?? "None")")
            applySelectedWallColor()
        }
        .onChange(of: appModel.isHideFurniture) { isHide in
            if let furniture = rootAnchor.findEntity(named: "furnitureEntity") {
                furniture.isEnabled = !isHide
                print("家具已\(isHide ? "隐藏" : "显示")")
                
            } else {
                print("未找到furnitureEntity实体")
            }
            let asset = appModel.currentFloorAsset
            let allItems = appModel.itemList.flatMap { $0.items } // 扁平化所有item
            if let item = allItems.first(where: { $0.materials.values.contains(asset) }) {
                let bakeKey = isHide ? "unbaked" : "baked"
                if let newFloorAsset = item.materials[bakeKey] {
                    appModel.currentFloorAsset = newFloorAsset
                    loadFloorModel()
                } else {
                    print("⚠️ 当前item缺少 \(bakeKey) 对应的模型名")
                }
                // appModel.currentDetailItem = item  // 可选同步
            } else {
                print("⚠️ 未找到当前地板item，无法切换形态")
            }
        }
    }
    
    func applySelectedWallColor() {
        guard let selectedColor = appModel.currentSelectedColor,
              let color = hexToCGColor(selectedColor.hex),
              let wall = rootAnchor.findEntity(named: "model_005"),
              let model = wall.components[ModelComponent.self],
              var shader = model.materials.last as? ShaderGraphMaterial
        else {
            print("⚠️ Missing required components to apply wall color")
            return
        }

        do {
            try shader.setParameter(name: "wallColor", value: .color(color))
            var newModel = model
            newModel.materials[model.materials.count - 1] = shader
            wall.components.set(newModel)
            print("✅ Wall color updated to \(selectedColor.colorName)")
        } catch {
            print("❌ Failed to apply shader parameter: \(error)")
        }
    }
    
    func printEntityNames(in entity: Entity, indent: String = "") {
        print("\(indent)\(entity.name)")
        for child in entity.children {
            printEntityNames(in: child, indent: indent + "  ")
        }
    }
    
    func findEntityRecursively(named name: String, in entity: Entity) -> Entity? {
        if entity.name == name {
            return entity
        }
        for child in entity.children {
            if let found = findEntityRecursively(named: name, in: child) {
                return found
            }
        }
        return nil
    }
    
    private func loadFloorModel() {
        Task {
            if let newFloorEntity = try? await Entity(named: appModel.currentFloorAsset, in: realityKitContentBundle) {
                if let oldFloor = floorEntity {
                    rootAnchor.removeChild(oldFloor)
                    oldFloor.removeFromParent()
                    oldFloor.components.removeAll()
                    print("Removed and destroyed old floor entity")
                }
                
                floorEntity = nil
                // try await Task.sleep(nanoseconds: 500_000_000)
                newFloorEntity.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
                rootAnchor.addChild(newFloorEntity)
                floorEntity = newFloorEntity
            } else {
                print("⚠️ Failed to load floor model: \(appModel.currentFloorAsset)")
            }
        }
    }
    
    private func loadWallModel() {
        Task {
            if let newWallEntity = try? await Entity(named: appModel.selectedWall, in: realityKitContentBundle) {
                if let oldWall = wallEntity {
                    rootAnchor.removeChild(oldWall)
                    oldWall.removeFromParent()
                    oldWall.components.removeAll()
                    print("Removed and destroyed old wall entity")
                }
                
                wallEntity = nil
                // try await Task.sleep(nanoseconds: 500_000_000)
                newWallEntity.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
                rootAnchor.addChild(newWallEntity)
                wallEntity = newWallEntity
                print("already changed wall")
            } else {
                print("⚠️ Failed to load wall model: \(appModel.selectedWall)")
            }
        }
    }
    
    func hexToCGColor(_ hex: String) -> CGColor? {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        guard hexFormatted.count == 6 else { return nil }

        var rgbValue: UInt64 = 0
        guard Scanner(string: hexFormatted).scanHexInt64(&rgbValue) else { return nil }

        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0x0000FF) / 255.0

        return CGColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    @State private var originalMaterials: [String: UnlitMaterial] = [:]
    
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
//        if let selectWallStyleEntity = rootAnchor.findEntity(named: "changeWallView") {
//            faceEntityTowardOrigin(selectWallStyleEntity)
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
    
    private func updateVirtualHomeViewVisibility(isVisible: Bool) {
        if let selectView = rootAnchor.findEntity(named: "VirtualHomeView") {
            selectView.isEnabled = isVisible
        }
    }
    
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
    
    private func addPointLight(to anchor: AnchorEntity) {
        let light = PointLight()
        light.light.intensity = 8000  // 可以调高亮度
        light.light.color = .white

        let lightEntity = Entity()
        lightEntity.addChild(light)

        lightEntity.position = [0, 2.5, 0]  // 高度越高，光照越柔和
        anchor.addChild(lightEntity)

        print("💡 虚拟点光源添加成功")
    }
    
    private func clearEntities() {
        print("reset scene")
        resetScene()
        print("start to clean")
        rootAnchor.children.removeAll()
        sceneAnchor1.children.removeAll()
        sceneAnchor2.children.removeAll()
        styleAnchor1.children.removeAll()
//        styleAnchor2.children.removeAll()
        //        selectHomeAnchor.children.removeAll()
        //        controlPanelAnchor.children.removeAll()
        
        print("All entities removed from anchors")
    }
    
    private func resetScene() {
        rootAnchor.position = .zero
        sceneAnchor1.position = [-1.5, 0, -2.5]
        sceneAnchor2.position = [2, 0, -3.5]
        styleAnchor1.position = [0.5, 0, -2.5]
//        styleAnchor2.position = [1.5, 0, -2]
        //        selectHomeAnchor.position = [0, 0, -1]
        //        controlPanelAnchor.position = [0, 0, -1]
    }
}
