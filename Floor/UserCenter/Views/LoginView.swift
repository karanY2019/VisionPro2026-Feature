//
//  LoginView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/22.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppModel.self) private var model
    @State private var username: String = ""
    @State private var selectedLocation: String = "O4H Flagship, SF"
    @State private var showTermOfService: Bool = false
    
    @State private var isUsernameExist: Bool = true
    @State private var isUsernameValid: Bool = true
    
    private var needShoowError: Bool {
        return !isUsernameValid || !isUsernameExist
    }
    
    // Available locations
    private let locations = ["O4H Flagship, SF", "O4H Downtown, SF", "O4H Valley, SF"]
    
    var body: some View {
        
        @Bindable var model = model
        
        ZStack {
            // Main Content
            VStack(spacing: 0) {
                // Top Location Selector
                HStack {
                    Spacer()
                    
                    Menu {
                        ForEach(model.distributors, id: \.id) { dealer in
                            Button {
                                model.currentDistributor = dealer
                            } label: {
                                HStack {
                                    Text(dealer.name)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.black.opacity(0.5))
                                }
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(8)
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            
                            Text(model.currentDistributor?.name ?? "Select Distributor")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white.opacity(0.96))
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white.opacity(0.23))
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 34)
                    .padding(.trailing, 38)
                }
                
                Spacer().frame(height: 14)
                
                // Main Login Content
                VStack(alignment: .center, spacing: 0) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 382, height: 64)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("Username", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(.system(size: 17))
                            .foregroundColor(.white.opacity(0.23))
                            .padding(.leading, 8) // 增加左边距，让占位符向右移动
                            .padding(.trailing, 4)
                            .padding(.vertical, 4)
                            .frame(height: 44)
                            .background(
                                Rectangle()
                                    .fill(.black.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            )
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
//                            .frame(height: 44)
                        
                        if needShoowError {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 10) {
                                    Image("red_attention")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    
                                    Text(getErrorMessage())
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color(red: 0.97, green: 0.14, blue: 0.14))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            .frame(maxWidth: 305, alignment: .leading)
                            .padding(.top, 8)
                        }
                
                        Text("Forget your O4H ID?")
                            .font(Font.custom("Poppins", size: 16))
                            .underline(true, pattern: .solid)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.96))
                            .padding(.top, needShoowError ? 16 : 8)
                            .onTapGesture {
                                model.accountPath.append(.forgetpwd)
                            }
                    }
                    .frame(width: 305)
                    .padding(.top, 80)
                    
                    VStack(alignment: .center, spacing: 16) {
                        Button {
                            
                            isUsernameValid = UCHelper.validateUserName(username)
                             
                            if isUsernameValid {
                                HttpClient.shared.userLogin(username: username) { result in
                                    switch result {
                                    case .success(let userResponse):
                                        print("✅ User login successful!")
                                        print("Response: \(userResponse)")
                                        
                                        Task { @MainActor in
                                            // 访问用户数据
                                            let userData = userResponse.data
                                            model.userData = userData
                                            
                                            // 登录成功后直接跳转到 AccountView
                                            model.accountPath.removeAll()
                                        }
                                        
                                    case .failure(let error):
                                        if case .apiError(let code, let message) = error {
                                            print("API Error: \(code), \(message)")
                                            // code: 811
//                                            if code == 404 {
                                            Task { @MainActor in
                                                isUsernameExist = false
                                            }
//                                            }
                                        }
                                    }
                                }
                            }
                            
                        } label: {
                            ZStack {
                                Color(red: 0.84, green: 0.84, blue: 0)
                                    .frame(width: 305, height: 44)
                                    .cornerRadius(22)
                                
                                Text("Log In")
                                    .font(.system(size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.16, green: 0.27, blue: 0.29))
                            }
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            model.accountPath.append(.register)
                        } label: {
                            ZStack {
                                Color(red: 0.16, green: 0.27, blue: 0.29)
                                    .frame(width: 305, height: 44)
                                    .cornerRadius(22)

                                Text("Create O4H ID")
                                    .font(.system(size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.86, green: 0.86, blue: 0.86))
                            }
                            
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 24)
                    
                    HStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                        
                        Text("or")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.96))
                            .padding(.horizontal, 8)
                        
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                    }
                    .frame(width: 305)
                    .padding(.top, 44)
                    
                    Text("Chat with our agent for help.")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.96))
                        .padding(.top, 44)
                    
                }
                
                Spacer()
                
                // Bottom Legal Text
                VStack {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("By logging in, you agree to our")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.6))
                        
//                        Text("Terms of Service")
//                            .font(.system(size: 12))
//                            .foregroundColor(.white.opacity(0.8))
//                            .underline()
//                            .onTapGesture {
//                                handleTermsOfService()
//                            }
//                        
//                        Text("&")
//                            .font(.system(size: 12))
//                            .foregroundColor(.white.opacity(0.6))
//                        
//                        Text("Privacy Policy")
//                            .font(.system(size: 12))
//                            .foregroundColor(.white.opacity(0.8))
//                            .underline()
                        
                        Text("Terms of Service & Privacy Policy")
                          .font(Font.custom("Poppins", size: 12))
                          .underline(true, pattern: .solid)
                          .multilineTextAlignment(.center)
                          .foregroundColor(.white.opacity(0.96))
                          .onTapGesture {
                              showTermOfService.toggle()
                          }
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showTermOfService) {
            TermsOfServiceView(isPresented: $showTermOfService)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Private
    private func getErrorMessage() -> String {
        if !isUsernameValid {
            return "Username must be between 4 and 20 characters long and can only contain letters and numbers"
        }
        if !isUsernameExist {
            return "Invalid ID. Try again or click Forgot ID."
        }
        return ""
    }
    
    // MARK: - Action Methods (To be implemented)
    private func handleLogin() {
        // TODO: Implement login logic
        print("Login tapped with username: \(username)")
    }
    
    private func handleCreateAccount() {
        // TODO: Implement create account logic
        print("Create account tapped")
    }
    
    private func handleForgetPassword() {
        // TODO: Implement forget password logic
        print("Forget password tapped")
    }
    
    private func handleChatWithAgent() {
        // TODO: Implement chat with agent logic
        print("Chat with agent tapped")
    }
    
    private func handleTermsOfService() {
        // TODO: Implement terms of service navigation
        print("Terms of service tapped")
        showTermOfService.toggle()
    }
    
    private func handlePrivacyPolicy() {
        // TODO: Implement privacy policy navigation
        print("Privacy policy tapped")
    }
    
    private func handleHomeNavigation() {
        // TODO: Implement home navigation
        print("Home navigation tapped")
    }
    
    private func handleProfileNavigation() {
        // TODO: Implement profile navigation (current page)
        print("Profile navigation tapped")
    }
}

#Preview {
    LoginView()
        .environment(AppModel())
}
