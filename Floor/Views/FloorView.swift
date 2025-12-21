//
//  FloorView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/2.
//

import SwiftUI

struct FloorView: View {
    
    @Environment(AppModel.self) private var model
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var selectedTab: ProductType = .floor
    
    var body: some View {
        
        @Bindable var model = model
        ZStack(alignment: .topLeading) {
            VStack(spacing: 24) {
                Text(model.currentProduct?.type.name ?? "Product")
                    .font(.system(size: 28))
                    .foregroundColor(.white.opacity(0.96))
                //                    .ignoresSafeArea(.all)
                    .padding(.top, 32)
                
                HStack {
                    Text(model.currentProduct?.title ?? "") // "Nature & Authenticity"
                        .font(
                            Font.custom("Poppins", size: 24)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.96))
                        .frame(width: 166, alignment: .top)
                    
                    Divider()
                        .padding(.horizontal, 64)
                    
                    Text(model.currentProduct?.description ?? "")
                        .font(
                            Font.custom("Poppins", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                        .frame(width: 779, alignment: .topLeading)
                    
                }
                .frame(height: 80)
                .padding(.horizontal, 80)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                        .fill(.ultraThickMaterial)
                )
                
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
//                        ForEach(allProducts) { item in
//                            ProductCell(item: item)
//                                .hoverEffect()
//                        }
                        ForEach(model.currentItems) {  itemDetail in
                            ProductCell2(item: itemDetail)
                                    .hoverEffect()
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            
            if !model.isMainWindowVisible {
                HStack {
                    Button {
                        let _ = model.navigationPath.popLast()
                        
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
                    .padding(.leading, 36)
                    .padding(.top, 28)
                    
                    Spacer()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack(spacing: 8) {
                TabButton(title: "Floor", type: .floor, selectedTab: $selectedTab)
                TabButton(title: "Cabinets", type: .cabinet, selectedTab: $selectedTab)
                    .disabled(true)
                TabButton(title: "Stairs", type: .stairs, selectedTab: $selectedTab)
                    .disabled(true)
                TabButton(title: "Door", type: .door, selectedTab: $selectedTab)
                    .disabled(true)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .glassBackgroundEffect()
            .clipShape(Capsule())
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            model.updateCurrentProduct(newValue)
        }
        .onAppear {
//            print("FloorView onAppear, model.currentItemList: \(model.currentItemList)")
//            print("FloorView onAppear, model.currentProduct: \(String(describing: model.currentProduct))")
            if let productType = model.currentProduct?.type {
                selectedTab = productType
            }

            // 埋点：进入 FloorView
            let username = model.userData?.username ?? "idle"
            TrackEvents.floorViewEnter.record(username: username, pagePath: "floor")
        }
        .onDisappear {
            // 埋点：离开 FloorView
            let username = model.userData?.username ?? "idle"
            TrackEvents.floorViewExit.record(username: username, pagePath: "floor")
        }
        
    }
}

struct TabButton: View {
    let title: String
    let type: ProductType
    @Binding var selectedTab: ProductType
    
    var body: some View {
        Button {
            selectedTab = type
        } label: {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    selectedTab == type ?
                    Capsule().fill(Color.white.opacity(0.3)) :
                    Capsule().fill(Color.clear)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FloorView()
}
