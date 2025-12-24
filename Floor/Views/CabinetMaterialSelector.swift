import SwiftUI
import CoreGraphics

struct CabinetMaterialSelector: View {
    @Environment(AppModel.self) private var appModel
    let materials: [CabinetMaterial]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(materials) { material in
                    VStack {
                        Circle()
                            .fill(Color(cgColor: material.color))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Circle()
                                    .stroke(appModel.currentCabinetMaterial.id == material.id ? 
                                           Color.white : Color.clear, lineWidth: 3)
                            )
                        
                        Text(material.name)
                            .font(.caption)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        appModel.currentCabinetMaterial = material
                        // Update immersive view
                        NotificationCenter.default.post(
                            name: .cabinetMaterialChanged, 
                            object: material
                        )
                    }
                }
            }
            .padding()
        }
        .frame(height: 100)
    }
}

#Preview {
    CabinetMaterialSelector(materials: [
        .default,
        .whiteMatte,
        .woodGrain,
        .darkWalnut,
        .grayModern
    ])
}
