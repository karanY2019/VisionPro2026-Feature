//
//  ProfileView.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AppModel.self) private var model
    
    // Available locations
    private let locations = ["O4H Flagship, SF", "O4H Downtown, SF", "O4H Valley, SF"]
    
    var body: some View {
        @Bindable var model = model
        
        NavigationStack(path: $model.accountPath) {
            ZStack {
                if let _ = model.userData, model.accountPath.isEmpty {
                    // 如果用户已登录且没有导航路径，显示 AccountView
                    AccountView()
                } else if let _ = model.userData {
                    // 如果用户已登录但有导航路径，根据路径显示相应视图
                    AccountView()
                } else {
                    // 如果用户未登录，显示 LoginView
                    LoginView()
                }
            }
            .navigationDestination(for: AccountPath.self) { router in
                switch router {
                case .login:
                    LoginView()
                case .register:
                    RegisterView()
                case .forgetpwd:
                    ForgetPasswordView()
                case .registerSuccess:
                    RegisterSuccessView()
                case .account:
                    AccountView()
                }
            }
        }
        
    }
}

#Preview {
    ProfileView()
        .environment(AppModel())
}
