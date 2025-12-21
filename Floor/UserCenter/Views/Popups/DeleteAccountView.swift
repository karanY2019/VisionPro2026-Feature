//
//  ChangeUsernameView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/28.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @Environment(AppModel.self) private var model
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        @Bindable var model = model
        
        VStack(alignment: .center, spacing: 0) {
            
            VStack(alignment: .center, spacing: 0) {
                Image("delete_account_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52)
                
                Spacer().frame(height: 8)
                
                Text("Delete Account")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.white.opacity(0.96))
                    .padding(.top, 8)
                
                Text("Your account will be deleted immediately after confirmation")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.63))
                    .padding(.bottom, 8)
            }
            
            Spacer().frame(height: 18)
            
            Divider().frame(width: 425)
            
            Spacer().frame(height: 18)
            
            VStack(alignment: .center, spacing: 0) {

                Button {
                    let username = model.userData?.username ?? ""
                    HttpClient.shared.deleteUser(query: UserQueryRequest(username: username)) { result in
                        switch result {
                        case .success():
                            print("delete user Successfully")
                            Task { @MainActor in
                                isPresented.toggle()
                                model.userData = nil
                                model.accountPath.removeAll()
                                model.accountPath.append(.login)
                            }
                        case .failure(let error):
                            print("Error updating username: \(error)")
                        }
                    }
                } label: {
                    Text("Delete")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color(red: 0.97, green: 0.14, blue: 0.14))
                        .frame(height: 44)
                        .padding(.horizontal, 20)
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
                
            }
            .padding(.horizontal, 80)
                
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 36)
    }
}

#Preview {
    DeleteAccountView(isPresented: Binding.constant(true))
}
