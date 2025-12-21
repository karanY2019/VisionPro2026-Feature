//
//  AccountDashboardContentView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/27.
//

import SwiftUI

struct AccountDashboardContentView: View {
    
    @Environment(AppModel.self) private var model
    
    @State private var showChangeUsername: Bool = false
    @State private var showChangeGeneralName: Bool = false
    @State private var showChangeEmail: Bool = false
    @State private var showDeleteAccount: Bool = false
    
    @State private var showTermOfService: Bool = false
    
    var fullName: String {
        let firstName = model.userData?.firstName ?? ""
        let lasetName = model.userData?.lastName ?? ""
        return "\(firstName) \(lasetName)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Text("Account Dashboard")
                    .font(.system(size: 30))
                    .foregroundStyle(.white.opacity(0.96))
                    .padding(.leading, 24)
            }
            .frame(width: .infinity, height: 92)
            
            HStack(alignment: .center, spacing: 52) {
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack(alignment: .center, spacing: 13) {
                        Image("username_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("Username")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                        
                    }
                    .frame(height: 48)
                    
                    HStack(alignment: .center, spacing: 13) {
                        Image("general_name_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("Name")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                        
                    }
                    .frame(height: 48)
                    
                    HStack(alignment: .center, spacing: 13) {
                        Image("email_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("Email")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                        
                    }
                    .frame(height: 48)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack(spacing: 13) {
                        // ACRTXsd
                        Text(model.userData?.username ?? "")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        
                        Text("Change")
                            .font(.system(size: 18))
                            .underline(pattern: .solid)
                            .foregroundStyle(.white.opacity(0.96))
                            .onTapGesture {
                                showChangeUsername.toggle()
                            }
                    }
                    .frame(height: 48)
                    
                    HStack(spacing: 13) {
                        // Customer Customer
                        Text(fullName)
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        
                        Text("Change")
                            .font(.system(size: 18))
                            .underline(pattern: .solid)
                            .foregroundStyle(.white.opacity(0.96))
                            .onTapGesture {
                                showChangeGeneralName.toggle()
                            }
                    }
                    .frame(height: 48)
                    
                    HStack(spacing: 13) {
                        // customer@oh4.com
                        Text(model.userData?.email ?? "-")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        
                        Text("Change")
                            .font(.system(size: 18))
                            .underline(pattern: .solid)
                            .foregroundStyle(.white.opacity(0.96))
                            .onTapGesture {
                                showChangeEmail.toggle()
                            }
                    }
                    .frame(height: 48)
                }
            }
            .padding(.horizontal, 44)
            
            HStack {
                Text("Delete Account")
                    .font(.system(size: 18))
                    .underline(pattern: .solid)
                    .foregroundStyle(.white.opacity(0.96))
                    .onTapGesture {
                        showDeleteAccount.toggle()
                    }
            }
            .frame(height: 48)
            .padding(.horizontal, 44)
            .padding(.top, 24)
            
            Spacer()
            
            HStack {
                Spacer()
                VStack(alignment: .center, spacing: 24) {
                    Button {
                        let username = model.userData?.username ?? ""
                        HttpClient.shared.userLogout(username: username) { result in
                            switch result {
                            case .success():
                                print("Successfully logout...")
                                Task { @MainActor in
                                    // 先清空用户数据
                                    model.userData = nil
                                    // 延迟一点时间再更新导航状态，避免环境对象丢失
                                    Task { @MainActor in
                                        try await Task.sleep(for: .milliseconds(100))
                                        model.accountPath.removeAll()
                                        model.accountPath.append(.login)
                                    }
                                }
                            case .failure(let error):
                                print("Error logout: \(error)")
                            }
                        }
                        
                    } label: {
                        ZStack {
                            Color(red: 0.16, green: 0.27, blue: 0.29)
                                .frame(width: 305, height: 44)
                                .cornerRadius(22)
                            
                            Text("Log out")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Text("Terms of Service & Privacy Policy")
                      .font(Font.custom("Poppins", size: 12))
                      .underline(true, pattern: .solid)
                      .multilineTextAlignment(.center)
                      .foregroundColor(.white.opacity(0.96))
                      .onTapGesture {
                          showTermOfService.toggle()
                      }
                }
                .padding(.bottom, 24)
                Spacer()
            }
        }
        .frame(width: .infinity, height: .infinity)
        .sheet(isPresented: $showChangeUsername) {
            ChangeUsernameView(isPresented: $showChangeUsername)
        }
        .sheet(isPresented: $showChangeGeneralName) {
            ChangeGeneralNameView(isPresented: $showChangeGeneralName)
        }
        .sheet(isPresented: $showChangeEmail) {
            ChangeEmailView(isPresented: $showChangeEmail)
        }
        .sheet(isPresented: $showDeleteAccount) {
            DeleteAccountView(isPresented: $showDeleteAccount)
        }
        .sheet(isPresented: $showTermOfService) {
            TermsOfServiceView(isPresented: $showTermOfService)
        }
    }
    
}

#Preview {
    AccountDashboardContentView()
}
