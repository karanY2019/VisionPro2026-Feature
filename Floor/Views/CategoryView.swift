//
//  CategoryView.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(AppModel.self) private var model
    
    var body: some View {
        
        @Bindable var model = model
        
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Button {
                        let _ = model.navigationPath.popLast()
//                        withAnimation(.spring()) {
//                            model.showCategory = false
//                        }
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

                    Text("Categories")
                        .font(.system(size: 28))
                        .padding(.horizontal, 480)
                }
                
                HStack(spacing: 16) {
                    ZStack (alignment: .bottom){
                        Image("floor")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 600, height: 600)
                            .cornerRadius(20)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image("floorIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            Text("Floor")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .glassBackgroundEffect()
                        .padding(.bottom, 20)
                    }
                    .onTapGesture {
                        print("floor tapped")
                        model.updateCurrentProduct(.floor)
                        model.navigationPath.append(.floor)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        ZStack (alignment: .bottom){
                            Image("stairs")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 290, height: 290)
                                .cornerRadius(20)
                            
                            HStack(alignment: .center, spacing: 8) {
                                Image("stairsIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                
                                Text("Stairs")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .glassBackgroundEffect()
                            .padding(.bottom, 20)
                        }
                        
                        ZStack (alignment: .bottom){
                            Image("door")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 290, height: 290)
                                .cornerRadius(20)
                            
                            HStack(alignment: .center, spacing: 8) {
                                Image("doorIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                
                                Text("Door")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .glassBackgroundEffect()
                            .padding(.bottom, 20)
                        }
                        
                    }
                    
                    ZStack (alignment: .bottom){
                        Image("cabinet")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 290, height: 600)
                            .cornerRadius(20)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image("cabinetIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            Text("Cabinet")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .glassBackgroundEffect()
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
//            .ignoresSafeArea(.all)
        }
}

#Preview {
    CategoryView()
}
