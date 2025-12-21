//
//  MyFavoriteCellView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/26.
//

import SwiftUI

struct MyFavoriteCellView: View {
    @Environment(AppModel.self) private var model
    
    @State private var showDeletePopup: Bool = false
    
    var item: PFavoriteItemInfo = .init()
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Color.clear.frame(width: 194, height: 100)
            
            HStack(alignment: .center, spacing: 20) {
//                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
//                    .fill(.blue)
//                    .frame(width: 100, height: 100)
                
                if let imageUrl = item.detailInfo.images.first?.url, let uiImage = UIImage(named: imageUrl) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                } else {
                    Text("Image not found")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.detailInfo.name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.96))
                    Text("Floor")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.23))
                }
            }
        }
        .popover(isPresented: $showDeletePopup) {
            Button {
                let favoriteItemId = item.favoriteData.id
                let deleteRequest = FavoriteDeleteRequest(id: favoriteItemId)
                HttpClient.shared.deleteFavorite(request: deleteRequest) { result in
                    switch result {
                    case .success():
                        print("✅ User delete favorite successful!")
                        Task { @MainActor in
                            // 更新 favorite items
                            model.fetchFavoriteItems { success, error in
                                if !success {
                                    print("❌ Fetch favorite items failed! error message: \(String(describing: error))")
                                }
                            }
                        }
                    case .failure(let error):
                        print("❌ User delete favorite failed! error message: \(String(describing: error.errorDescription))")
                    }
                }
                Task { @MainActor in
                    showDeletePopup = false
                }
            } label: {
                HStack {
                    Text("Delete")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color(red: 1, green: 0.27, blue: 0.23))
                        .padding(.leading, 20)
                    Spacer()
                    Image("favorite_delete_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 22)
                        .padding(.trailing, 20)
                }
                .frame(width: 220, height: 40)
            }
            .buttonStyle(.plain)
        }
        .onTapGesture {
            Task { @MainActor in
                model.detailNavigationContext = .userCenter
                model.updateCurrentDetailItemFromAllProducts(item.detailInfo.id)
                
                model.navigationPath.removeAll()
                model.navigationPath.append(.detail)
                
                model.selectedTab = .home
            }
        }
        .onLongPressGesture {
            showDeletePopup.toggle()
        }
    }
}


#Preview {
    MyFavoriteCellView()
}
