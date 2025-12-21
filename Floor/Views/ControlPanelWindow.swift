import SwiftUI

struct ControlPanelWindow: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ControlPanelButton(
                    imageName: "exit",
                    title: "Exit",
                    action: {
                        Task {
                            dismissWindow(id: "ControlPanelWindow")
                            dismissWindow(id: "ImmersiveSpaceMainWindow")
                            dismissWindow(id: "MainWindow")
                            openWindow(id: "MainWindow")
                            appModel.isClearEntities = false
                            appModel.isClearEntitiesForRoom2 = false
                            try await Task.sleep(nanoseconds: 500_000_000)
                            appModel.isClearEntities = true
                            appModel.isClearEntitiesForRoom2 = true
                            await dismissImmersiveSpace()
//                            appModel.virtualHomeViewVisible = true
                            appModel.isMainWindowVisible = false
                            appModel.isDecorationVisible = false
                            appModel.isLayoutPageVisible = false
                        }
                    }
                )
                
                DividerLine()
                
                ControlPanelButton(
                    imageName: "productsIcon",
                    title: "Layout",
                    action: {
                        appModel.isMainWindowVisible = false
                        appModel.isDecorationVisible = false
                        appModel.isLayoutPageVisible.toggle()
                    }
                )
                
                DividerLine()
                
                ControlPanelButton(
                    imageName: "homeStyleIcon",
                    title: "Wall Paint",
                    action: {
                        appModel.isMainWindowVisible = false
                        appModel.isLayoutPageVisible = false
                        appModel.isDecorationVisible.toggle()
                    }
                )
                
                DividerLine()
                
                ControlPanelButton(
                    imageName: "productsIcon",
                    title: "Products",
                    action: {
                        appModel.isDecorationVisible = false
                        appModel.isLayoutPageVisible = false
                        toggleMainWindow()
                    }
                )
                
                DividerLine()
                
                ControlPanelButton(
                    imageName: appModel.isHideFurniture ? "showFurnitureIcon" : "hideIcon",
                    title: appModel.isHideFurniture ? "Show Furniture" : "Hide Furniture",
                    action: {
                        print("Hide Furniture button pressed")
                        appModel.isHideFurniture.toggle()
                    }
                )
            }
        }
        .frame(width: 980, height: 60)
    }
    
    private func toggleMainWindow() {
        appModel.updateCurrentProduct(.floor)
        appModel.isMainWindowVisible.toggle()
        if let index = appModel.navigationPath.firstIndex(of: .detail) {
            appModel.navigationPath.remove(at: index)
            print("Removed old detail page from navigation path.")
        }
        if let floors = appModel.navigationPath.firstIndex(of: .floor) {
//            appModel.navigationPath.remove(at: floors)
//            print("Removed old floor page from navigation path.")
        } else {
            appModel.navigationPath.append(.floor)
        }
//        if appModel.isMainWindowVisible {
//            openWindow(id: "ImmersiveSpaceMainWindow")
//        } else {
//            dismissWindow(id: "ImmersiveSpaceMainWindow")
//        }
    }
}
    
struct ControlPanelButton: View {
    @Environment(AppModel.self) private var appModel

    let imageName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            let username = appModel.userData?.username ?? "idle"
            TrackEvents.immersiveControlPanelClick.record(
                username: username,
                pagePath: "immersive_space_control_panel_window",
                trackData: ["button": title]
            )
            action()
        } label: {
            HStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 36)
            .frame(height: 60)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}
//        GeometryReader { geometry in
//            
//            VStack(spacing: 20.0) {
//                VStack {
//                    Text(geometry.size.width.description)
//                        .font(.largeTitle)
//                    Text("width")
//                        .font(.subheadline)
//                }
//                VStack {
//                    Text(geometry.size.height.description)
//                        .font(.largeTitle)
//                    Text("height")
//                        .font(.subheadline)
//                }
//            }
//            .position(
//                x: geometry.frame(in: .local).midX,
//                y: geometry.frame(in: .local).midY
//            )
//            
//        }



/// 分割线组件
struct DividerLine: View {
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 1, height: 40)
    }
}
