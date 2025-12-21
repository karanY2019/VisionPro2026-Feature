import SwiftUI

struct FrostedUI: View {
    
    var onPress: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {
                print("Button Pressed!")
                onPress()
            }) {
                Image("flashIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
        }
        .padding(16)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 75)
        )
        .frame(width: 150, height: 150)
    }
}
