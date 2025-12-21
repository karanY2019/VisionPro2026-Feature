//
//  AccountView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/25.
//

import SwiftUI

struct AccountView: View {
    
    @Environment(AppModel.self) private var model
    
    @State private var tabMode: AccountContentTabMode = .favorite
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("My Account")
                            .font(.system(size: 29, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 28)
                    

                    VStack(alignment: .leading, spacing: 10) {
                        
                        // favorite row
                        Button(action: {
                            self.tabMode = .favorite
                        }) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 11)
                                    .fill(tabMode == .favorite ? .white.opacity(0.07) : Color.clear)
                                
                                HStack(spacing: 12) {
                                    Image("my_favorite")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .padding(.leading, 12)
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("My Favorite")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.white.opacity(0.96))
                                        
                                        Text("View & manage wishlists")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundStyle(Color(red: 0.65, green: 0.65, blue: 0.65))
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 296, height: 56)
                        .hoverEffect(.highlight)
                        .cornerRadius(11)
                        
                        // dashboard row
                        Button(action: {
                            self.tabMode = .dashboard
                        }) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 11)
                                    .fill(tabMode == .dashboard ? .white.opacity(0.07) : Color.clear)
                                
                                HStack(spacing: 12) {
                                
                                    Image("account_dashboard")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .padding(.leading, 12)
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("Account Dashboard")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.white.opacity(0.96))
                                        
                                        Text("Review your account settings")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundStyle(Color(red: 0.65, green: 0.65, blue: 0.65))
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 296, height: 56)
                        .hoverEffect(.highlight)
                        .cornerRadius(11)
                    }
                    
                    Spacer()
                }
                .frame(width: 320, height: .infinity)
                .background(.black.opacity(0.08))
                
                if tabMode == .favorite {
                    MyFavoriteContentView()
                } else {
//                    Color.green
                    AccountDashboardContentView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AccountView()
}
