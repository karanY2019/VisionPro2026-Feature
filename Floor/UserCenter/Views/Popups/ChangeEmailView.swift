//
//  ChangeUsernameView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/28.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @Environment(AppModel.self) private var model
    
    @State var email: String = ""
    @Binding var isPresented: Bool
    
    @State var isEmailValid: Bool = true
    let errorMsg : String = "Invalid email. Please check email format."
    
    var body: some View {
        
        @Bindable var model = model
        
        VStack(alignment: .center, spacing: 0) {
            
            VStack(alignment: .center, spacing: 0) {
                Image("change_email_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52)
                
                Spacer().frame(height: 8)
                
                Text("Email")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.white.opacity(0.96))
                    .padding(.top, 8)
                
                Text("Type in a new email below to update")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.63))
                    .padding(.bottom, 8)
            }
            
            Spacer().frame(height: 18)
            
            VStack(alignment: .center, spacing: 0) {
                TextField("E-Mail", text: $email)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 17))
                    .foregroundColor(.white.opacity(0.23))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
                    .background(
                        Rectangle()
                            .fill(.black.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(isEmailValid ? .white.opacity(0.3) : .red.opacity(0.8), lineWidth: 1)
                            )
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(width: 305, height: 44)
                
                Spacer().frame(height: 18)

                Button {
                    
                    isEmailValid = UCHelper.validateEmailFormat(email)
                    if email.isEmpty {
                        isEmailValid = false
                    }
                    if isEmailValid {
                        
                        let id = model.userData?.id ?? 0
                        let username = model.userData?.username ?? ""
                        let firstName = model.userData?.firstName ?? ""
                        let lastName = model.userData?.lastName ?? ""
                        let email = email
                        let dealerId = model.userData?.dealerId ?? 0
                        
                        let requeset = UserUpdateRequest(id: id, username: username, firstName: firstName, lastName: lastName, email: email, dealerId: dealerId)
                        
                        HttpClient.shared.updateUser(request: requeset) { (result) in
                            switch result {
                            case .success(let response):
                                print("Successfully updated username: \(response.data)")
                                Task { @MainActor in
                                    model.userData = response.data
                                    isPresented.toggle()
                                }
                            case .failure(let error):
                                print("Error updating username: \(error)")
                            }
                        }
                    }
                    
                } label: {
                    ZStack {
                        Color(red: 0.84, green: 0.84, blue: 0)
                            .frame(width: 305, height: 44)
                            .cornerRadius(22)
                        
                        Text("Update")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.16, green: 0.27, blue: 0.29))
                    }
                }
                .buttonStyle(.plain)
                
                Spacer().frame(height: 18)
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Cancel")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white.opacity(0.23))
                        .frame(height: 44)
                        .padding(.horizontal, 20)
                }
                .buttonStyle(.plain)
                
                if !isEmailValid {
                    HStack(spacing: 12) {
                        Image("red_attention")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 8)
                        Text(errorMsg)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(red: 0.97, green: 0.14, blue: 0.14))
                            .padding(.trailing, 8)
                    }
                    .frame(height: 36)
                }
            }
            .padding(.horizontal, 80)
                
        }
        .padding(.horizontal, 20)
        .padding(.top, 36)
        .padding(.bottom, isEmailValid ? 36 : 0)
    }
}

#Preview {
    ChangeEmailView(isPresented: Binding.constant(true))
}
