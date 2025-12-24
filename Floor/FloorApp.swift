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
        
        // Main immersive space for LaunchSpace
        ImmersiveSpace(id: appModel.launchSpaceID) {
            LaunchSpace()
                .environment(appModel)
                .onAppear {
                    appModel.launchSpaceState = .open
                    print("🚀 FloorApp: LaunchSpace opened successfully")
                }
                .onDisappear {
                    appModel.launchSpaceState = .closed
                }
        }
        
        // Main window for the app
        WindowGroup(id: "MainWindow") {
            ContentView()
                .environment(appModel)
                .environment(globalState)
        }
        .windowResizability(.contentSize)
         
    }
}
