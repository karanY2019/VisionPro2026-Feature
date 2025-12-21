//
//  ChooseDistributorView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/7/6.
//

import SwiftUI

struct ChooseDistributorView: View {
    
    @Environment(AppModel.self) private var model
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 24) {
            
            ScrollView {
                VStack(alignment: .center, spacing: 8) {
                    ForEach(model.distributors, id: \.id) { distributor in
                        ZStack {
                            Color.clear
                            Text(distributor.name)
                                .font(.system(size: 28))
                                .foregroundStyle(model.currentDistributor?.id == distributor.id ? .white : .white.opacity(0.6))
                        }
                        .frame(width: 290)
                        .onTapGesture {
                            model.currentDistributor = distributor
                        }
                        .hoverEffect()
                    }
                }
            }
            .frame(width: 300, height: 120)
            
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(height: 1)
            
            Button {
                
                if model.currentDistributor != nil {
                    isPresented.toggle()
                }
                
            } label: {
                ZStack {
                    Color(red: 0.84, green: 0.84, blue: 0)
                        .frame(width: 305, height: 44)
                        .cornerRadius(22)

                    Text("Start")
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.16, green: 0.27, blue: 0.29))
                }
                
            }
            .buttonStyle(.plain)
            
        }
        .frame(width: 305)
        .padding(.horizontal, 80)
        .padding(.bottom, 24)
        .padding(.top, 90)
    }
}
