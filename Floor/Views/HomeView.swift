//
//  HomeView.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    @Environment(AppModel.self) private var model

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    private let root = Entity()
    private var portalPlane = ModelEntity(
        mesh: .generatePlane(width: 0.40, height: 0.41, cornerRadius: 0.013),
        materials: [PortalMaterial()]
    )
    private let showPortal: Bool = true
    @State private var currentModelName: String = "Villa_No2_2"
    @State private var worldEntity: Entity? = nil
    
    // 模型字典，用于存储所有预加载的模型
    @State private var modelEntities: [String: [Entity]] = [:]

    // 可用的模型名称列表
    private let availableModelGroups: [String: [String]] = [
        "Villa_No2_2": ["HexChangeWallColor", "Novara_floor", "Furnitures", "House0912"],
        "Royalwood_1226": ["Royalwood_1226"]
    ]
        
    @State private var showChooseDistributor: Bool = false
    
    var body: some View {
        
        @Bindable var model = model
        
        NavigationStack(path: $model.navigationPath) {
            ZStack {
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 382, height: 64)
                        
                        Spacer()
                        
                        Button {
                            showChooseDistributor = true
                        } label: {
                            Text(model.currentDistributor?.name ?? "-")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white.opacity(0.96))
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white.opacity(0.23))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                    }
                    
                    
                    HStack(alignment: .center, spacing: 30) { // 40
                        ZStack(alignment: .bottom) {
                            // RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            //     .frame(width: 580, height: 558)
                            //     .overlay(content: {
                            //         Image("home")
                            //         .resizable()
                            //         .aspectRatio(contentMode: .fit)
                            //         .frame(width: 580, height: 558)
                            //     })
                            
                            Image("home")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 580, height: 558)
                                .cornerRadius(20)
                            
                            Button {
                                withAnimation(.spring()) {
                                    model.updateCurrentProduct(.floor)
                                    model.navigationPath.append(.floor)
                                }
                                
                            } label: {
                                Text("View Products")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 260, height: 60)
                                    .background(
                                        Color(red: 0.16, green: 0.27, blue: 0.29)
                                    )
                                    .cornerRadius(40)
                            }
                            .buttonStyle(.plain)
                            .padding(.bottom, -20)
                        }
                        
                        ZStack (alignment: .bottom){
                            if showPortal {
                                portalView
                                    .overlay {
                                        VStack {
                                            Picker("Style", selection: $model.selectedStyle) {
                                                Text("Contemporary").tag(0)
                                                Text("Transitional").tag(1)
                                            }
                                            .pickerStyle(.segmented)
                                            .font(.system(size: 18, weight: .medium))
                                            .frame(width: 270, height: 44)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(22)
                                            .glassBackgroundEffect()
                                            .padding(.top, 16)
                                            
                                            Spacer()
                                        }
                                    }
                                
                                
                            } else {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .frame(width: 580, height: 558)
                                    .overlay {
                                        Image("stairs")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 580, height: 558)
                                    }
                            }
                            
                            ToggleImmersiveSpaceButton()
                                .simultaneousGesture(TapGesture().onEnded {
                                    let username = model.userData?.username ?? "idle"
                                    TrackEvents.buttonClick.record(username: username,
                                                                   pagePath: "home",
                                                                   extraInfo: "toggleImmersiveSpace")
                                })
                        }
                        .padding(.horizontal, 0)
                        .padding(.vertical, 16)
                    }
                    .navigationDestination(for: Router.self) { router in
                        if router == .category {
                            CategoryView()
                        }
                        if router == .floor {
                            FloorView()
                        }
                        if router == .detail {
                            FloorDetail(queryPath: model.detailNavigationContext)
                        }
                        
                    }
                    .padding(.leading, 20)
                }
                .padding(.horizontal, 32)
            }
            .onChange(of: model.selectedStyle) { oldValue, newValue in
                if newValue == 0 {
                    currentModelName = "Villa_No2_2"
                    model.currentImmersiveSpaceID = "SecondImmersiveSpace"
                } else if newValue == 1 {
                    currentModelName = "Royalwood_1226"
                    model.currentImmersiveSpaceID = "ImmersiveSpace"
                }
                // 显示当前选中的模型，隐藏其他模型
                updateModelVisibility()
                updateWorldOrientation()
            }
            .sheet(isPresented: $showChooseDistributor) {
                ChooseDistributorView(isPresented: $showChooseDistributor)
            }
            .onAppear {
                showChooseDistributor = model.currentDistributor == nil

                // 埋点：进入 HomeView
                let username = model.userData?.username ?? "idle"
                TrackEvents.homeViewEnter.record(username: username, pagePath: "home")
            }
            .onDisappear {
                // 埋点：离开 HomeView
                let username = model.userData?.username ?? "idle"
                TrackEvents.homeViewExit.record(username: username, pagePath: "home")
            }
        }
    }
    
    var portalView: some View {
        ZStack {
            GeometryReader3D { geometry in
                RealityView { content in
                    await createPortal()
                    content.add(root)
                } update: { content in
                    let _ = content.convert(geometry.size, from: .local, to: .scene)
                }
                .frame(depth: 0.4)
            }
            .frame(depth: 0.4)
            .clipShape(RoundedRectangle(cornerRadius: 20)) // no
        }
        .frame(width: 580, height: 558)
    }
    
    @MainActor func createPortal() async {
        let world = Entity()
        world.scale *= 0.8
        world.orientation = simd_quatf(angle: .pi * (120/180), axis: [0, 1, 0]) // Villa_No2_2
//        world.orientation = simd_quatf(angle: .pi * (-15/180), axis: [0, 1, 0])  // Royalwood_1226
        world.position.x += 0
        world.position.y -= 0.65 // 0.35
        world.position.z += 0.9
        world.components.set(WorldComponent())
        
        // 存储世界实体引用
        worldEntity = world

        // 创建天空盒并添加到世界
        if let skybox = createSkybox() {
            world.addChild(skybox)
        }
        
        // 预加载所有模型
        await preloadAllModels(on: world)
        
        // 更新模型可见性
        updateModelVisibility()
        
        root.addChild(world)
        portalPlane.components.set(PortalComponent(target: world))
        root.addChild(portalPlane)
    }
    
    // 预加载所有可用模型
    @MainActor func preloadAllModels(on world: Entity) async {
        for (groupName, entityNames) in availableModelGroups {
            var loadedEntities: [Entity] = []
            for name in entityNames {
                do {
                    let entity = try await Entity(named: name, in: realityKitContentBundle)
                    entity.isEnabled = false

                    if name == "HexChangeWallColor" {
                        entity.transform.scale = SIMD3<Float>(repeating: 100)

                        if let rootWall = findEntityRecursively(named: "Wall525", in: entity),
                           let area = findEntityRecursively(named: "Wall", in: rootWall),
                           let wall = findEntityRecursively(named: "model_005", in: area),
                           let model = wall.components[ModelComponent.self] {

                            if var shader = model.materials.last as? ShaderGraphMaterial {
                                if let color = hexToCGColor("#EBE0CE") {
                                    try? shader.setParameter(name: "wallColor", value: .color(color))
                                    var newModel = model
                                    newModel.materials[model.materials.count - 1] = shader
                                    wall.components.set(newModel)
                                    print("✅ Applied default white color to HexChangeWallColor")
                                }
                            }
                        }
                    }

                    world.addChild(entity)
                    loadedEntities.append(entity)
                } catch is CancellationError {
                    print("⚠️ 加载模型 \(name) 被取消")
                } catch {
                    print("加载模型 \(name) 出错: \(error.localizedDescription)")
                }
            }
            modelEntities[groupName] = loadedEntities
        }
    }
    
    // 更新模型可见性
    @MainActor func updateModelVisibility() {
        guard worldEntity != nil else { return }
        
        for (groupName, entities) in modelEntities {
            let isCurrent = (groupName == currentModelName)
            for entity in entities {
                entity.isEnabled = isCurrent
            }
        }
    }
    
    @MainActor func updateWorldOrientation() {
        guard let worldEntity = worldEntity else { return }
        
        let angleMap: [String: Float] = [
            "Villa_No2_2": 120,
            "Royalwood_1226": -40
        ]
        
        let angle = angleMap[currentModelName, default: 120]
        worldEntity.orientation = simd_quatf(angle: .pi * (angle / 180), axis: [0, 1, 0])
    }
    
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
    
}

#Preview {
    HomeView()
        .environment(AppModel())
}

