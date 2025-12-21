//
//  FloorApp.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import SwiftUI

@main
struct FloorApp: App {

    @State private var appModel = AppModel()
    @State private var globalState = GlobalState()

    var body: some Scene {
        
        ImmersiveSpace(id: appModel.welcomeViewID) {
            LaunchSpace()
                .environment(appModel)
                .onAppear {
                    appModel.launchSpaceState = .open
                }
                .onDisappear {
                    appModel.launchSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: appModel.welcomeViewID) {
            WelcomeView()
                .environment(appModel)
                .onAppear {
                    appModel.welcomeViewState = .open
                }
                .onDisappear {
                    appModel.welcomeViewState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        WindowGroup(id: "MainWindow") {
            MainView()
                .environment(appModel)
                .environment(globalState)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "ImmersiveSpaceMainWindow") {
            ImmersiveSpaceMainView()
                .environment(appModel)
                .environment(globalState)
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain)

        
        WindowGroup(id: "ControlPanelWindow") {
            ControlPanelWindow()
                .environment(appModel)
        }
        .defaultSize(CGSize(width: 800, height: 60))
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
         .immersionStyle(selection: .constant(.full), in: .full)
        
        ImmersiveSpace(id: appModel.secondImmersiveSpaceID) {
            SecondImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
         .immersionStyle(selection: .constant(.full), in: .full) // 现实世界的光照影响场景
        
        ImmersiveSpace(id: appModel.modelFullSpaceID) {
//            ModelView()
            ModelView2()
                .environment(appModel)
                .onAppear {
                    appModel.modelFullSpaceState = .open
                }
                .onDisappear {
                    appModel.modelFullSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
         
    }
}
