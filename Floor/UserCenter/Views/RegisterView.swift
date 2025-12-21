//
//  RegisterView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/22.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(AppModel.self) private var model
    
    @State private var username: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    @State private var isUsernameValid: Bool = true
    @State private var isFirstnameValid: Bool = true
    @State private var isLastnameVaild: Bool = true
    @State private var isEmailVaild: Bool = true
    
    @State private var isUsernameAlreadyExist: Bool = false
    @State private var isEmailAlreadyExist: Bool = false
    
    @State private var showTermOfService: Bool = false
    
    var needShowErrorMessage: Bool {
        return !isUsernameValid ||
                !isFirstnameValid ||
                !isLastnameVaild ||
                !isEmailVaild ||
                isUsernameAlreadyExist ||
                isEmailAlreadyExist
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                
//                Spacer().frame(height: 89)
                
                Text("Create O4H ID")
                    .font(.system(size: 30))
                    .foregroundStyle(.white.opacity(0.96))
                
                Spacer().frame(height: 44)
                
                VStack(alignment: .center, spacing: 18) {

                    TextField("Username", text: $username)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.23))
                        .padding(.leading, 8) // 增加左边距，让占位符向右移动
                        .padding(.trailing, 4)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            isUsernameValid = UCHelper.validateUserName(username)
                        }
                        .frame(width: 305, height: 44, alignment: .leading)
                        .background(
                            Rectangle()
                                .fill(.black.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke((isUsernameValid && !isUsernameAlreadyExist) ? .white.opacity(0.3) : .red.opacity(0.8), lineWidth: 1)
                                )
                        )
                    
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.23))
                        .padding(.leading, 8) // 增加左边距，让占位符向右移动
                        .padding(.trailing, 4)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            isFirstnameValid = UCHelper.validateGeneralName(firstName)
                        }
                        .frame(width: 305, height: 44, alignment: .leading)
                        .background(
                            Rectangle()
                                .fill(.black.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(isFirstnameValid ? .white.opacity(0.3) : .red.opacity(0.8), lineWidth: 1)
                                )
                        )
                    
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.23))
                        .padding(.leading, 8) // 增加左边距，让占位符向右移动
                        .padding(.trailing, 4)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            isLastnameVaild = UCHelper.validateGeneralName(lastName)
                        }
                        .frame(width: 305, height: 44, alignment: .leading)
                        .background(
                            Rectangle()
                                .fill(.black.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(isLastnameVaild ? .white.opacity(0.3) : .red.opacity(0.8), lineWidth: 1)
                                )
                        )
                    
                    TextField("E-Mail(Optional)", text: $email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.23))
                        .padding(.leading, 8) // 增加左边距，让占位符向右移动
                        .padding(.trailing, 4)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            isEmailVaild = UCHelper.validateEmailFormat(email)
                        }
                        .frame(width: 305, height: 44, alignment: .leading)
                        .background(
                            Rectangle()
                                .fill(.black.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke((isEmailVaild && !isEmailAlreadyExist) ? .white.opacity(0.3) : .red.opacity(0.8), lineWidth: 1)
                                )
                        )
                }
                
                Spacer().frame(height: 44)
                
                Button {
                    
                    // Validate all fields
                    isUsernameValid = UCHelper.validateUserName(username)
                    isFirstnameValid = UCHelper.validateGeneralName(firstName)
                    isLastnameVaild = UCHelper.validateGeneralName(lastName)
                    isEmailVaild = UCHelper.validateEmailFormat(email)
                
                    isUsernameAlreadyExist = false
                    isEmailAlreadyExist = false
                    
                    if isUsernameValid &&
                        isFirstnameValid &&
                        isLastnameVaild &&
                        isEmailVaild &&
                        !isUsernameAlreadyExist &&
                        !isEmailAlreadyExist {
                        
                        guard let dealerId = model.currentDistributor?.id else {
                            print("❌ Failed to get dealer ID from current selection.")
                            return
                        }
                        
                        let createRequest = UserCreateRequest(
                            username: username,
                            firstName: firstName,
                            lastName: lastName,
                            email: email.isEmpty ? nil : email,
                            dealerId: dealerId // Default dealer ID, you may want to make this configurable
                        )
                        
                        HttpClient.shared.createUser(request: createRequest) { result in
                            
                            switch result {
                            case .success(let userResponse):
                                print("✅ User registration successful!  response: \n \(userResponse)")
                                Task { @MainActor in
                                    model.userData = userResponse.data
                                    model.accountPath.append(.registerSuccess)
                                }
                            case .failure(let error):
                                print("❌ User registration failed! error message: \(String(describing: error.errorDescription))")
                                if case .apiError(let code, let message) = error {
                                    print("API Error: \(code), \(message)")
                                    // code: 812 , 用户已存在
                                    if code == 812 {
                                        Task { @MainActor in
                                            isUsernameAlreadyExist = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    ZStack {
                        Color(red: 0.84, green: 0.84, blue: 0)
                            .frame(width: 305, height: 44)
                            .cornerRadius(22)
                        Text("Create")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.16, green: 0.27, blue: 0.29))
                    }
                   
                }
                .buttonStyle(.plain)
                
                Spacer().frame(height: 4)
                
                Text("Username will be used as the login credential.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.96))
                
                if needShowErrorMessage {
                    HStack(spacing: 10) {
                        Image("red_attention")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text(getErrorMessage())
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color(red: 0.97, green: 0.14, blue: 0.14))
                            
                    }
                    .frame(width: 380)
                    .padding(.top, 10)
                }
                
                Spacer()
                
                // Bottom Legal Text
                VStack {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("By creating, you agree to our")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.6))
                        
//                        Text("Terms of Service")
//                            .font(.system(size: 12))
//                            .foregroundColor(.white.opacity(0.8))
//                            .underline()
//                            .onTapGesture {
//                                showTermOfService.toggle()
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
    }
    
    // MARK: - Private
    private func getErrorMessage() -> String {
        if !isUsernameValid {
            return "Username must be between 4 and 20 characters long and can only contain letters and numbers"
        }
        if isUsernameAlreadyExist {
            return "Username already existed"
        }
        if !isFirstnameValid {
            return "Please enter a valid name"
        }
        if !isLastnameVaild {
            return "Please enter a valid name"
        }
        if !isEmailVaild {
            return "Invalid email. Please check email format."
        }
        if isEmailAlreadyExist {
            return "Email already existed."
        }
        return ""
    }
    
    private func getUserNameErrorMessage() -> String {
        if !isUsernameValid {
            return "Username must be between 4 and 20 characters long and can only contain letters and numbers"
        }
        if isUsernameAlreadyExist {
            return "Username already existed"
        }
        return ""
    }
    
    private func getFirstNameErrorMessage() -> String {
        if !isFirstnameValid {
            return "Please enter a valid name"
        }
        return ""
    }
    
    private func getLastNameErrorMessage() -> String {
        if !isLastnameVaild {
            return "Please enter a valid name"
        }
        return ""
    }
    
    private func getEmailErrorMessage() -> String {
        if !isEmailVaild {
            return "Invalid email. Please check email format."
        }
        if isEmailAlreadyExist {
            return "Email already existed."
        }
        return ""
    }
    
}

#Preview {
    RegisterView()
}
