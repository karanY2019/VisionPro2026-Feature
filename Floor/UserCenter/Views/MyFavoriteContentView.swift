//
//  MyFavoriteContentView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/27.
//
import SwiftUI

struct MyFavoriteContentView: View {
    @Environment(AppModel.self) private var model
    
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // 添加过滤逻辑的计算属性
    private var filteredItems: [PFavoriteItemInfo] {
        if searchText.isEmpty {
            return model.favoriteItems
        } else {
            return model.favoriteItems.filter { item in
                item.detailInfo.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Text("My Favorite")
                    .font(.system(size: 30))
                    .foregroundStyle(.white.opacity(0.96))
                    .padding(.leading, 24)
            }
            .frame(width: .infinity, height: 92)
            
            ZStack(alignment: .leading) {
                Color.black.opacity(0.1)
                    .frame(height: 44)
                    .cornerRadius(22)
                
                HStack(spacing: 8) {
                    Image("audio_mic_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .padding(.leading, 8)
                    
                    TextField("Search", text: $searchText)
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(0.23))
                }
            }
            .frame(width: .infinity, height: 44)
            .padding(.horizontal, 24)
            .padding(.vertical, 0)
            
            // No Favorite Items
            if model.favoriteItems.isEmpty {
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 24) {
                            Text("No Favorite Items")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(filteredItems, id: \.self.detailInfo.name) { favoriteData in
                            MyFavoriteCellView(item: favoriteData)
                                .hoverEffect()
                        }
                    }
                }
                .padding(24)
            }
        }
        .frame(width: .infinity, height: .infinity)
    }
    
}


