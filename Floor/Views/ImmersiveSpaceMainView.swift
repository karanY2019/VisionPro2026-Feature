//
//  ImmersiveSpaceMainView.swift
//  Floor
//
//  Created by Scuuu on 2025/3/1.
//

import SwiftUI

struct ImmersiveSpaceMainView: View {
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(GlobalState.self) private var globalState
    @Environment(AppModel.self) private var appModel
    @State var selectedTab: Int = 0
    
    var body: some View {
        
        if appModel.isMainWindowVisible {
//            TabView(selection: $selectedTab) {
//                
//                ImmersiveSpaceCategoryView()
//                //                .frame(width: 1080, height: 720, alignment: .center)
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(0)
//                
//                CompareView()
//                    .tabItem {
//                        Label("Compare", systemImage: "arrow.2.circlepath")
//                    }
//                    .tag(1)
//                
//                SearchView()
//                    .tabItem {
//                        Label("Search", systemImage: "magnifyingglass")
//                    }
//                    .tag(2)
//                
//                ProfileView()
//                    .tabItem {
//                        Label("Profile", systemImage: "person")
//                    }
//                    .tag(3)
//                
//                //            PageView2()
//                //                .tabItem {
//                //                    Label("Pages", systemImage: "pencil")
//                //                }
//                //                .tag(3)
//            }
//            .frame(width: 1280, height: 720) // 1080 -> 1280, adapt to tab view.
//            .frame(minWidth: 1280, maxWidth: 1280, minHeight: 720, maxHeight: 720)
//            .onAppear {
//                selectedTab = 0
//            }
//            .onChange(of: selectedTab) { _, newValue in
//                if newValue != 0 {
//                    if appModel.modelFullSpaceState == .open {
//                        Task {
//                            appModel.modelFullSpaceState = .inTransition
//                            await dismissImmersiveSpace()
//                        }
//                    }
//                }
//            }
            ImmersiveSpaceCategoryView()
                .glassBackgroundEffect()
                .ornament(attachmentAnchor: .scene(.init(x: 0.5, y: 1.15))) {
                    //            HStack {
                    //                Text("hello")
                    //            }
                    //            .frame(width: 200,height: 50)
                    //            .glassBackgroundEffect()
                    ControlPanelWindow()
                        .glassBackgroundEffect()
                }
        } else if appModel.isDecorationVisible == true {
            HStack(spacing: 0) {
                // 左侧部分 - 空白区域或者其他内容
//                Spacer()
//                    .frame(width: 380)
                ChangeWallColorView()
                    .glassBackgroundEffect()
//                    .frame(width: 900, height: 720) // 1080 -> 1280, adapt to tab view.
//                    .frame(minWidth: 900, maxWidth: 900, minHeight: 720, maxHeight: 720)
                    .ornament(attachmentAnchor: .scene(.init(x: 0.5, y: 1.1))) {
                        //            HStack {
                        //                Text("hello")
                        //            }
                        //            .frame(width: 200,height: 50)
                        //            .glassBackgroundEffect()
                        ControlPanelWindow()
                            .glassBackgroundEffect()
                    }
//                    .ornament(attachmentAnchor: .scene(.init(x: 0.145, y: 0.5))) {
//                        //            HStack {
//                        //                Text("hello")
//                        //            }
//                        //            .frame(width: 200,height: 50)
//                        //            .glassBackgroundEffect()
//                        ChangeRoomView()
//                            .glassBackgroundEffect()
//                    }
            }
        } else if appModel.isLayoutPageVisible == true {
            HStack(spacing: 0) {
                ChangeRoomView()
                    .glassBackgroundEffect()
                    .ornament(attachmentAnchor: .scene(.init(x: 0.5, y: 1.1))) {
                        //            HStack {
                        //                Text("hello")
                        //            }
                        //            .frame(width: 200,height: 50)
                        //            .glassBackgroundEffect()
                        ControlPanelWindow()
                            .glassBackgroundEffect()
                    }
            }
        } else {
            VStack{
                
            }
            .frame(width: 1280, height: 720) // 1080 -> 1280, adapt to tab view.
            .frame(minWidth: 1280, maxWidth: 1280, minHeight: 720, maxHeight: 720)
            .ornament(attachmentAnchor: .scene(.init(x: 0.5, y: 1.15))) {
                //            HStack {
                //                Text("hello")
                //            }
                //            .frame(width: 200,height: 50)
                //            .glassBackgroundEffect()
                ControlPanelWindow()
                    .glassBackgroundEffect()
            }
        }
    }
}

#Preview {
    ImmersiveSpaceMainView()
}
