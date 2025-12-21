import SwiftUI

struct ChangeStyleView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow
    @Environment(AppModel.self) private var appModel
    @State private var showStyleView: Bool = false
    
    var onPress: (Bool) -> Void
    
    var body: some View {
        if !showStyleView {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Button(action: {
                        showStyleView = true
                        onPress(true)
                    }) {
                        Text(appModel.currentDetailItem?.name ?? "T02BL")
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
            }
            .frame(alignment: .leading)
        } else {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            showStyleView = false
                            onPress(false)
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 60, height: 60)
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 60, height: 60)
                        .contentShape(Circle())
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        Button(action: {
                            
                            if let selectedItem = appModel.currentDetailItem {
                                print("Navigating to details of: \(selectedItem.name)")
                                if let index = appModel.navigationPath.firstIndex(of: .detail) {
                                    appModel.navigationPath.remove(at: index)
                                    print("Removed old detail page from navigation path.")
                                }
                                if let floors = appModel.navigationPath.firstIndex(of: .floor) {
//                                    appModel.navigationPath.remove(at: floors)
//                                    print("Removed old floor page from navigation path.")
                                } else {
                                    appModel.navigationPath.append(.floor)
                                }
                                DispatchQueue.main.async {
                                    appModel.detailNavigationContext = .normal
                                    appModel.navigationPath.append(.detail)
                                    print("Navigating to FloorDetail")
                                }
                                if (appModel.isMainWindowVisible == false) {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 延迟0.5秒
                                       appModel.isMainWindowVisible = true
                                   }
                                } else {
                                    appModel.isMainWindowVisible = true
                                }
//                                appModel.isMainWindowVisible = true
                            } else {
                                print("⚠️ No selected item to show details.")
                            }
                        }) {
                            Text("Show Details")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding([.top, .horizontal])
                    
                    HStack {
                        Text("Select and show another product.")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 15)
                }
                
                if showStyleView {
                    ScrollView {
                        VStack(spacing: 10) {
                            let items = appModel.currentItems

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                                ForEach(appModel.currentItems, id: \.id) { item in
                                    StyleButton(item: item, onSelect: {
//                                        appModel.updateCurrentDetailItem(item.id)
                                        appModel.updateCurrentDetailItem(item.id)
                                    })
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .frame(width: 750, height: 600)
//            .background(
//                Color.black.opacity(0.2)
//            )
//            .background(
//                .ultraThinMaterial,
//                in: RoundedRectangle(cornerRadius: 24)
//            )
            .onAppear {
                print("Current Product:", appModel.currentProduct?.title ?? "No product selected")
                print("Current Items:", appModel.currentItems.count)
                
                if appModel.currentProduct == nil, let firstProduct = appModel.productList.first {
                    appModel.updateCurrentProduct(firstProduct.type)
                }
            }
        }
    }
}
    
struct StyleButton: View {
    let item: PItemDetail
    var onSelect: () -> Void
    @Environment(AppModel.self) private var appModel

    var isSelected: Bool {
        return appModel.currentDetailItem?.id == item.id
    }
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(named: item.thumbnailUrl) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 120)
                    .clipShape(Circle())
            } else {
                Text("Image Not Found")
                    .frame(width: 120, height: 120)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            
            Text(item.name)
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 100)
        }
        .padding(8)
        .background(isSelected ? Color.black.opacity(0.5) : Color.clear)
        .cornerRadius(12)
        .onTapGesture {
            print("Selected item: \(item.name)")
            onSelect()
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
