//
//  MainView.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import SwiftUI

struct MainView: View {
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(GlobalState.self) private var globalState
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        
        @Bindable var appModel = appModel

        TabView(selection: $appModel.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(BizTab.home)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(BizTab.profile)
        }
        .frame(width: 1280, height: 720) // 1080 -> 1280, adapt to tab view.
        .frame(minWidth: 1280, maxWidth: 1280, minHeight: 720, maxHeight: 720)
        .onAppear {
            appModel.selectedTab = .home
        }
        .onChange(of: appModel.selectedTab) { _, newValue in
            if newValue != .home {
                if appModel.modelFullSpaceState == .open {
                    Task {
                        appModel.modelFullSpaceState = .inTransition
                        await dismissImmersiveSpace()
                    }
                }
            }
            
            if newValue == .profile {
                if appModel.detailNavigationContext == .userCenter {
                    appModel.navigationPath.removeAll()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
