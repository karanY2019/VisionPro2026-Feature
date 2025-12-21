//
//  PageView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/3.
//

import SwiftUI

struct PageView: View {
    // 存储颜色数组
    let colors: [Color] = [.red, .blue, .green, .yellow]
    
    var body: some View {
        TabView {
            ForEach(colors.indices, id: \.self) { index in
                Rectangle()
                    .fill(colors[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 设置为垂直方向滚动
        .rotationEffect(.degrees(-90))
        // 修正内容方向
        .scrollTargetBehavior(.paging)
    }
}

struct PageView2: View {
    
    let colors: [Color] = [.red, .blue, .green, .yellow]
    
//    let images: [String] = [
//        "floor1",
//        "floor2",
//        "floor3",
//        "floor4",
//    ]
    
    let images: [String] = [
        "T02BL_1",
        "T02BL_2",
        "T02BL_3",
        "T02BL_4",
    ]
    
    @State private var currentIndex: Int? = 0
    @GestureState private var translation: CGFloat = 0
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        
        if let imagesInfo = appModel.currentDetailItem?.images {
            GeometryReader { geometry in
                ZStack(alignment: .trailing) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(imagesInfo.indices, id: \.self) { index in
    //                            Rectangle()
    //                                .fill(colors[index])
    //                                .frame(width: geometry.size.width, height: geometry.size.height)
    //                                .id(index)
                                
    //                            Image(images[index])
    //                                .resizable()
    //                                .scaledToFill()
    //                                .frame(width: geometry.size.width, height: geometry.size.height)
    //                                .id(index)
                                
                                // images[index]
                                if let uiImage = UIImage(named: imagesInfo[index].url) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .id(index)
                                } else {
                                    Text("Image not found")
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $currentIndex)
                    
                    CustomIndicator(currentIndex: $currentIndex, count: imagesInfo.count)
                        .padding(.trailing, 20)
                    
//                    Button(action: {
//                        print("View in VR tapped!")
//                        Task { @MainActor in
//                            switch appModel.immersiveSpaceState {
//                            case .open:
//                                print("immersive space has already opened")
//                            case .closed:
//                                appModel.immersiveSpaceState = .inTransition
//                                switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
//                                case .opened:
//                                    break
//                                case .userCancelled, .error:
//                                    fallthrough
//                                @unknown default:
//                                    appModel.immersiveSpaceState = .closed
//                                }
//                            case .inTransition:
//                                break
//                            }
//                        }
//                    }) {
//                        Text("View In VR")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(.white)
//                            .padding(12)
//                            .cornerRadius(8)
//                    }
//                    .padding(.top, -335)
//                    .padding(.trailing, 20)
                }
                
            }
        } else {
            Text("Loading...")
        }
    }
}

struct CustomIndicator: View {
    @Binding var currentIndex: Int?
    let count: Int
    
    var body: some View {
        VStack {
            ForEach(0..<count, id: \.self) { index in
                if index != currentIndex {
                    Circle()
                        .fill(Color(red: 217.0/255, green: 217.0/255, blue: 217.0/255))
                        .frame(width: 8, height: 8)
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .frame(width: 8, height: 24)
                }
            }
        }
    }
}

#Preview("CustomIndicator") {
    CustomIndicator(currentIndex: .constant(1), count: 5)
        .background(Color.black)  // 添加背景色以便看清白色指示器
}

#Preview("PageView") {
    PageView()
}
