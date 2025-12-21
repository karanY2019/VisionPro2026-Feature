import SwiftUI

struct ChangeRoomView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow
    
    @Environment(AppModel.self) private var appModel
    
    @State private var isTransitioning: Bool = false

    
    var body: some View {
        VStack(spacing: 0) {
            // Title: "Home Style"
            Text("Layout")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 29)
            
            Spacer().frame(height: 142)
            
            HStack(spacing: 0) {
                RoomButton(image: "immersiveSpace_02", text: "Contemporary", buttonSpaceID: "SecondImmersiveSpace", onSelect: {
                    Task {
                        if appModel.currentImmersiveSpaceID != "SecondImmersiveSpace" {
                            appModel.currentImmersiveSpaceID = "SecondImmersiveSpace"
                            appModel.isClearEntities = false
                            appModel.isClearEntitiesForRoom2 = false
                            try await Task.sleep(nanoseconds: 500_000_000)
                            appModel.isClearEntities = true
                            appModel.isClearEntitiesForRoom2 = true
                            await toggleImmersiveSpace()
                            dismissWindow(id: "MainWindow")
                            dismissWindow(id: "ImmersiveSpaceMainWindow")
                            openWindow(id: "ImmersiveSpaceMainWindow")
        //                    appModel.virtualHomeViewVisible = false
                        }
                        
                    }
                })
                
                Spacer().frame(width: 120)
                
                RoomButton(image: "immersiveSpace_01", text: "Transitional", buttonSpaceID: "ImmersiveSpace", onSelect: {
                    Task {
                        if appModel.currentImmersiveSpaceID != "ImmersiveSpace" {
                            appModel.currentImmersiveSpaceID = "ImmersiveSpace"
                            appModel.isClearEntities = false
                            appModel.isClearEntitiesForRoom2 = false
                            try await Task.sleep(nanoseconds: 500_000_000)
                            appModel.isClearEntities = true
                            appModel.isClearEntitiesForRoom2 = true
                            await toggleImmersiveSpace()
                            dismissWindow(id: "MainWindow")
                            dismissWindow(id: "ImmersiveSpaceMainWindow")
                            openWindow(id: "ImmersiveSpaceMainWindow")
        //                    appModel.virtualHomeViewVisible = false
                        }
                    }
                })
            }
            Spacer()
        }
    }
    
    private func toggleImmersiveSpace() async {
        guard !isTransitioning else { return }
        
        isTransitioning = true

        let targetSpaceID = appModel.currentImmersiveSpaceID
                
        await dismissImmersiveSpace()
        
        let result = await openImmersiveSpace(id: targetSpaceID)
        switch result {
            case .opened:
                print("Successfully opened space: \(targetSpaceID)")
            case .userCancelled:
                print("User cancelled opening space: \(targetSpaceID)")
            case .error:
                print("Failed to open space: \(targetSpaceID)")
            @unknown default:
                print("Unknown result when opening space: \(targetSpaceID)")
        }
        
        isTransitioning = false
    }
}

struct RoomButton: View {
    var image: String
    var text: String
    var buttonSpaceID: String
    var onSelect: () -> Void
    @Environment(AppModel.self) private var appModel

    var isSelected: Bool {
        return appModel.currentImmersiveSpaceID == buttonSpaceID
    }
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 312, height: 312)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1.74))
            
            Text(text)
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 200)
        }
        .padding(.init(top: 19, leading: 44, bottom: 19, trailing: 44))
        .background(isSelected ? Color.black.opacity(0.15) : Color.clear)
        .cornerRadius(25)
        .onTapGesture {
            // 埋点
            let username = appModel.userData?.username ?? "idle"
            TrackEvents.styleSelect.record(
                username: username,
                pagePath: "change_room",
                trackData: ["selectedStyle": text]
            )
            
            onSelect()
        }
    }
}

#Preview {
    ChangeRoomView()
}
