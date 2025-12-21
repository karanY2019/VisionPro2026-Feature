//
//  WelcomeView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/12.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct WelcomeView: View {
    
    @State var container: Entity = Entity()
    @State var textOpacity: Float = 0.0
    @State var easeOutFlag: Bool = false
    
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    @Environment(AppModel.self) private var model
    
    var body: some View {
        RealityView { content in
            _ = addText("OPEN HOME")
            container.components.set(OpacityComponent(opacity: textOpacity))
            content.add(container)
        }
        .onAppear {
            easeOutFlag = false
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { easeInTimer in
                if textOpacity < 1.0 {
                    textOpacity += 0.05
                    container.components.set(OpacityComponent(opacity: textOpacity))
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        easeOutFlag = true
                    }
//                    print("timer1: textOpacity = \(textOpacity)")
                    easeInTimer.invalidate()
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { easeOutTimer in
                if easeOutFlag {
                    if textOpacity > 0.0 {
                        textOpacity -= 0.05
                        container.components.set(OpacityComponent(opacity: textOpacity))
//                        print("timer2: textOpacity = \(textOpacity)")
                    } else {
                        easeOutTimer.invalidate()
                        
                        // open main window
                        openWindow(id: "MainWindow")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            Task {
                                if model.welcomeViewState == .open {
                                    await dismissImmersiveSpace()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func loadLogo() -> Entity {
        let logoEntity = Entity()
        // Create plane mesh
        let planeMesh = MeshResource.generatePlane(width: 0.5, height: 0.3)
        // Create material with home image
//        var material = SimpleMaterial(color: .red, isMetallic: true)
        var material = UnlitMaterial()
        material.color = .init(tint: .white, texture: .init(try! .load(named: "home")))
        // Create model entity with mesh and material
        let logoModel = ModelEntity(mesh: planeMesh, materials: [material])
        logoEntity.addChild(logoModel)
        
        return logoEntity
    }
    
    private func addText(_ text: String) -> Entity {
        let textMeshResource: MeshResource = .generateText(text,
                                                           extrusionDepth: 0.05,
                                                           font: .init(name: "Optima-Bold", size: 0.25) ?? .systemFont(ofSize: 0.25),
                                                           containerFrame: .zero,
                                                           alignment: .center,
                                                           lineBreakMode: .byWordWrapping)
        let material = UnlitMaterial(color: .white)  // Start fully transparent
        let textEntity = ModelEntity(mesh: textMeshResource, materials: [material])
        textEntity.position = SIMD3(x: -(textMeshResource.bounds.extents.x / 2), y: 1.5, z: -1.5)
        container.addChild(textEntity)
        
        return textEntity
    }
}

#Preview(immersionStyle: .mixed) {
    WelcomeView()
        .environment(AppModel())
}
