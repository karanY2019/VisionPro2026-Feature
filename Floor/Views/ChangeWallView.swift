//
//  ChangeWallView.swift
//  Floor
//
//  Created by Scuuu on 2025/3/11.
//

import SwiftUI

struct ChangeWallView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow
    @Environment(AppModel.self) private var appModel
    @State private var showWallView: Bool = false
    
    var onPress: (Bool) -> Void
    
    var body: some View {
        if !showWallView {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Button(action: {
                        showWallView = true
                        onPress(true)
                    }) {
                        Text(appModel.selectedWall ?? "Wall_A")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 280, height: 80)
                    }
                    .buttonStyle(.plain)
                }
                .padding(20)
//                .background(
//                    .ultraThinMaterial,
//                    in: RoundedRectangle(cornerRadius: 75)
//                )
//                .frame(width: 600, height: 360, alignment: .leading)
            }
            .frame(alignment: .leading)
        } else {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            showWallView = false
                            onPress(false)
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 44, height: 44)
                        .background(
                            Color.clear.contentShape(Rectangle())
                                .frame(width: 60, height: 60)
                        )
                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    
                    HStack {
                        Text("Select a wall texture.")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 10)
                }
                
                if showWallView {
                    VStack(spacing: 10) {
                        HStack(spacing: 20) {
                            WallButton(name: "Wall_A", imageName: "Wall_A", onSelect: {
                                print("select wall A")
                                appModel.selectedWall = "Wall_A"
                            }, isSelected: appModel.selectedWall == "Wall_A")
                            
                            WallButton(name: "Wall_B", imageName: "Wall_B", onSelect: {
                                print("select wall B")
                                appModel.selectedWall = "Wall_B"
                            }, isSelected: appModel.selectedWall == "Wall_B")
                        }
                        .padding()
                    }
                }
            }
            .frame(width: 400, height: 320)
//            .background(
//                Color.black.opacity(0.2)
//            )
//            .background(
//                .ultraThinMaterial,
//                in: RoundedRectangle(cornerRadius: 24)
//            )
        }
    }
}
    
struct WallButton: View {
    let name: String
    let imageName: String
    var onSelect: () -> Void
    var isSelected: Bool
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 100)
                    .clipShape(Circle())
            } else {
                Text("Image Not Found")
                    .frame(width: 100, height: 100)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            
            Text(name)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 100)
        }
        .padding(8)
        .background(isSelected ? Color.black.opacity(0.5) : Color.clear)
        .cornerRadius(12)
        .onTapGesture {
            print("Selected wall: \(name)")
            onSelect()
        }
    }
}
