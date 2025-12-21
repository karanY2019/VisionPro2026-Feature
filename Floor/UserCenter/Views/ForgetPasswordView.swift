//
//  ForgetPasswordView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/22.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var email: String = ""
    @State private var isEmailVaild: Bool = true
    @State private var emailNotExist: Bool = false
    
    @State private var username: String = ""
    
    var needShowErrorMessage: Bool {
        return  !isEmailVaild ||
                emailNotExist
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 0) {
                
                Spacer().frame(height: 50)
                
                VStack(alignment: .center) {
                    Text("Forgot your username?")
                        .font(.system(size: 24))
                        .foregroundStyle(.white.opacity(0.96))
                    Text("Don’t worry — we’ll help you find it.")
                        .font(.system(size: 24))
                        .foregroundStyle(.white.opacity(0.96))
                }
                
                Spacer().frame(height: 86)
                
                VStack(alignment: .center, spacing: 18) {
                    TextField("E-Mail", text: $email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.23))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.black.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke( needShowErrorMessage ? .red.opacity(0.8) : .white.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(width: 305, height: 44)
                    
                    Button {
                        
                        isEmailVaild = UCHelper.validateEmailFormat(email)
                        if email.isEmpty {
                            isEmailVaild = false
                        }
                        if isEmailVaild {
                            HttpClient.shared.getCodeByEmail(email: email) { result in
                                switch result {
                                case .success(let userResponse):
                                    print("✅ getCodeByEmail successful!  response: \n \(userResponse)")
                                    Task { @MainActor in
                                        username = userResponse
                                        emailNotExist = false
                                    }
                                  
                                case .failure(let error):
                                    if case .apiError(let code, let message) = error {
                                        print("API Error: \(code), \(message)")
                                        // code: 811
//                                        if code == 404 {
                                        Task { @MainActor in
                                            emailNotExist = true
                                            username = ""
                                        }
//                                        }
                                    }
                                }
                            }
                        } else {
                            username = ""
                        }
                        
                    } label: {
                        ZStack {
                            Color(red: 0.16, green: 0.27, blue: 0.29)
                                .frame(width: 305, height: 44)
                                .cornerRadius(22)
                            
                            // Send username to your Email
                            Text("Retrieve your username")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer().frame(height: needShowErrorMessage ? 8 : 44)
                
                if needShowErrorMessage {
                    HStack(spacing: 10) {
                        Image("red_attention")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text(getEmailErrorMessage())
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color(red: 0.97, green: 0.14, blue: 0.14))
                            
                    }
                    .frame(width: 380)
                    .padding(.top, 10)
                }
                
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
                .frame(width: 305, height: 18)
                
                Spacer().frame(height: 44)
                
                Text("Chat with our agent for help.")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white.opacity(0.96))
                
//                Spacer().frame(height: 187)
                if !username.isEmpty {
                    VStack(spacing: 4) {
                        Text("Your username is: ")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white.opacity(0.96))
                        Text(username)
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.96))
                            .padding(.top, 20)
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            .frame(width: .infinity, height: 628)
            .padding(.top, 92)
        }
        .frame(width: .infinity, height: .infinity)
       
    }
    
    
    private func getEmailErrorMessage() -> String {
        if !isEmailVaild {
            return "Invalid email. Please check email format."
        }
        if emailNotExist {
            return "Email is not registed with us. Please try again"
        }
        return ""
    }
}

#Preview {
    ForgetPasswordView()
}
