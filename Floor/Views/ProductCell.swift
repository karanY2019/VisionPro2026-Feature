//
//  ProductCell.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/2.
//

import SwiftUI

struct ProductCell: View {
    
    @Environment(AppModel.self) private var model
    
    var item: ProductItem = .init(name: "Tropea1", icon: "tropea1")
    var body: some View {
        ZStack(alignment: .center) {
            
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                .fill(.thinMaterial)
            
            VStack(alignment: .center) {
                if let uiImage = UIImage(named: item.icon) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 156, height: 218)
                } else {
                    Text("Image not found")
                }
                
                HStack(alignment: .center) {
                    
                    Text(item.name)
                        .padding(.leading, 10)
                }
            }
        }
        .onTapGesture {
            model.detailNavigationContext = .normal
            model.navigationPath.append(.detail)
        }
        //.frame(width: .infinity, height: 194)
    }
}

struct ProductCell2: View {
    
    @Environment(AppModel.self) private var model
    
    var item: PItemDetail = .init()
    var body: some View {
        ZStack(alignment: .center) {
            
//            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
//                .fill(.thinMaterial)
            
            VStack(alignment: .center) {
                if let uiImage = UIImage(named: item.thumbnailUrl) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 256, height: 256)
                } else {
                    Text("Image not found")
                }
                
//                Image("breathe2")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 156, height: 218)
                
                HStack(alignment: .center) {
                    Text(item.name)
                        .padding(.leading, 10)
                }
            }
        }
        .onTapGesture {
            model.detailNavigationContext = .normal
            model.updateCurrentDetailItem(item.id)
            model.navigationPath.append(.detail)
        }
        //.frame(width: .infinity, height: 194)
    }
}

#Preview {
    ProductCell()
}
