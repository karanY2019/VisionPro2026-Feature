//
//  RegisterSuccessView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/24.
//

import SwiftUI

struct RegisterSuccessView: View {
    
    @Environment(AppModel.self) private var model
    @State private var showTermOfService: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                Image("tada")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 183, height: 183)
                
                Spacer().frame(height: 65)
                
                ZStack {
                    VStack(alignment: .center) {
                        Text("Your O4H ID")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white.opacity(0.96))
                        Text(model.userData?.username ?? "ACEJHS")
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: 422, height: 114)
                .background(Color.black.opacity(0.1))
                .cornerRadius(18)
                
                if let email = model.userData?.email, email.count > 0 {
                    Text("Your O4H ID will be sent to your email shortly.")
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(0.96))
                }
                
                Spacer().frame(height: 85)
                
                Button {
                    // 清空 accountPath 并跳转到 AccountView
                    model.accountPath.removeAll()
                    
                } label: {
                    ZStack {
                        Color(red: 0.84, green: 0.84, blue: 0)
                            .frame(width: 304, height: 44)
                            .cornerRadius(22)
                        Text("Continue")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.16, green: 0.27, blue: 0.29))
                    }
                }
                .buttonStyle(.plain)
                
                Spacer().frame(height: 87)
                
                // Bottom Legal Text
                VStack {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("By logging in, you agree to our")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.6))
                        
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
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showTermOfService) {
            TermsOfServiceView(isPresented: $showTermOfService)
        }
    }
}

#Preview {
    RegisterSuccessView()
}
