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
                    if selectedTab == .cabinet {
                        // Show cabinet images when cabinets tab is selected
                        LazyVGrid(columns: columns, spacing: 16) {
                            CabinetImageCard(imageName: "cabinetDove", title: "Dove", description: "Clean white cabinet finish")
                            CabinetImageCard(imageName: "cabinetCharcoal", title: "Charcoal", description: "Modern dark cabinet finish")
                            CabinetImageCard(imageName: "cabinetSAGE", title: "SAGE", description: "Natural green cabinet finish")
                        }
                    } else {
                        // Show regular floor products
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(model.currentItems) {  itemDetail in
                                ProductCell2(item: itemDetail)
                                        .hoverEffect()
                            }
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
                TabButton(title: "Stairs", type: .stairs, selectedTab: $selectedTab)
                // is disabled, not clickable 
                    //.disabled(true) 
                TabButton(title: "Door", type: .door, selectedTab: $selectedTab)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .glassBackgroundEffect()
            .clipShape(Capsule())
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            print("🔄 FloorView: Tab changed from \(oldValue) to \(newValue)")
            print("📊 FloorView: Available products count: \(model.productList.count)")
            print("📊 FloorView: Available items count: \(model.itemList.count)")
            
            // Debug: Check if product exists for this type
            if let product = model.productList.first(where: { $0.type == newValue }) {
                print("✅ FloorView: Found product for \(newValue): \(product.title)")
            } else {
                print("❌ FloorView: No product found for type: \(newValue)")
            }
            
            // Debug: Check current items before update
            print("📊 FloorView: Current items before update: \(model.currentItems.count)")
            
            model.updateCurrentProduct(newValue)
            
            // Debug: Check current items after update
            print("📊 FloorView: Current items after update: \(model.currentItems.count)")
            print("📊 FloorView: Current product after update: \(String(describing: model.currentProduct))")
        }
        .onAppear {
            print("🏠 FloorView: onAppear called")
            print("📊 FloorView: Available products: \(model.productList.map { $0.type.rawValue })")
            print("📊 FloorView: Available items types: \(model.itemList.map { $0.type.rawValue })")
            
            if let productType = model.currentProduct?.type {
                selectedTab = productType
                print("📊 FloorView: Set initial tab to: \(productType)")
            } else {
                print("⚠️ FloorView: No current product found, defaulting to .floor")
            }

            // TrackEvents calls removed to avoid compilation errors
        }
        .onDisappear {
            print("👋 FloorView: onDisappear called")
        }
        
    }
}

struct CabinetImageCard: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .cornerRadius(8)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white.opacity(0.96))
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
        .hoverEffect()
    }
}

struct TabButton: View {
    let title: String
    let type: ProductType
    @Binding var selectedTab: ProductType
    
    var body: some View {
        Button {
            print("🔘 TabButton tapped: \(title) (type: \(type))")
            selectedTab = type
            print("✅ selectedTab updated to: \(selectedTab)")
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
