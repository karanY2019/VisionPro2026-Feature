import SwiftUI

struct VirtualHomeView: View {
    @State private var selectedImage: String = "view1"
    @State private var isTransitioning: Bool = false
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow
    
    @Environment(AppModel.self) private var appModel
        
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 50) {
                VStack(spacing: 10) {
                    Image("immersiveSpace_02")
                        .resizable()
                        .frame(width: selectedImage == "view1" ? 400 : 300, height: selectedImage == "view1" ? 400 : 300)
                        .scaleEffect(selectedImage == "view1" ? 1.1 : 1.0)
                        .zIndex(selectedImage == "view1" ? 1 : 0)
                        .onTapGesture {
                            selectedImage = "view1"
                        }
                    
                    Text("Transitional")
                        .font(.system(size: selectedImage == "view1" ? 48 : 28))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 10) {
                    Image("immersiveSpace_01")
                        .resizable()
                        .frame(width: selectedImage == "view2" ? 400 : 300, height: selectedImage == "view2" ? 400 : 300)
                        .scaleEffect(selectedImage == "view2" ? 1.1 : 1.0)
                        .zIndex(selectedImage == "view2" ? 1 : 0)
                        .onTapGesture {
                            selectedImage = "view2"
                        }
                    
                    Text("Contemporary")
                        .font(.system(size: selectedImage == "view2" ? 48 : 28))
                        .foregroundColor(.white)
                }
            }
            
            Button(action: {
                Task {
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
            }) {
                Text("Select Style")
                    .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: 200, height: 44)
                        .background(Color(red: 0.84, green: 0.84, blue: 0))
                        .cornerRadius(40)
            }
            .frame(width: 224, height: 68)
            .background(
                Color(red: 0.5, green: 0.5, blue: 0.5)
                    .blur(radius: 30)
            )
            .cornerRadius(40)
            .clipped()
            .disabled(isTransitioning)
        }
        .padding()
        .ignoresSafeArea()
    }
    
    
    
    private func toggleImmersiveSpace() async {
        guard !isTransitioning else { return }
        
        isTransitioning = true
                
        let targetSpaceID = selectedImage == "view1" ? "SecondImmersiveSpace" : "ImmersiveSpace"
        
        appModel.currentImmersiveSpaceID = targetSpaceID
        
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
