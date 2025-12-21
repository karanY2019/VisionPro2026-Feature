//
//  FloorDetail.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/1/2.
//

import SwiftUI

struct FloorDetail: View {
    
    @Environment(AppModel.self) private var appModel
    
    var queryPath: QueryDetailPath = .normal
    
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State private var showLoginPopup: Bool = false
    @State private var isHeartFilled: Bool = false
    
    var body: some View {
        @Bindable var model = appModel
        ZStack(alignment: .topLeading) {
            HStack(spacing: 48) {
                //                if let uiImage = UIImage(named: "tropea1") {
                //                    Image(uiImage: uiImage)
                //                        .resizable()
                //                        .aspectRatio(contentMode: .fill)
                //                        .frame(width: 780, height: 720)
                //                } else {
                //                    Text("Image not found")
                //                }
                
                PageView2()
                    .frame(width: 780, height: 720)
                
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(model.currentDetailItem?.name ?? "") // "F06EL"
                            .font(
                                Font.custom("Poppins", size: 48)
                                    .weight(.medium)
                            )
                            .foregroundColor(.white.opacity(0.96))
                            .padding(.top, 20)
                        
                        Text(model.currentDetailItem?.description ?? "")
                            .font(
                                Font.custom("Poppins", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(.white.opacity(0.96))
                            .frame(maxWidth: 410, alignment: .topLeading)
                        
                        VStack(alignment: .leading, spacing: 24) {
                            FloorDetailStripe(name: "SPECS")
                            FloorDetailStripe(name: "MATERIAL & CARE")
                            FloorDetailStripe(name: "WARRANTY & RETURN")
                            FloorDetailStripe(name: "FAQ")
                        }
                        .frame(maxWidth: 410)
                        
                        Spacer()
                    }
                }
                .frame(width: 410)
                
                Spacer()
            }
            
            HStack {
                Button {
                    if queryPath == .normal {
                        let _ = model.navigationPath.popLast()
                        Task {
                            await closeImmersiveSpace()
                        }
                    } else {
                        // user center
                        model.selectedTab = .profile
                    }
                   
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                .frame(width: 44, height: 44)
                .background(
                    Color.clear.contentShape(Rectangle())
                        .frame(width: 60, height: 60)
                )
                .padding(.leading, 36)
                .padding(.top, 28)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
//        .ornament(attachmentAnchor: .scene(.init(x: 0.5, y: 1.1))) {
//            if true {
//                HStack {
//                    Text("hello")
//                }
//                .frame(width: 200,height: 50)
//                .glassBackgroundEffect()
//            }
//           
//        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack(spacing: 16) {
                
                /*
                Button {
                   // TODO: VIC
                    
                } label: {
                    Text("Compare")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(
                            Color(red: 42.0/255, green: 68.0/255, blue: 75.0/255)
                                .frame(width: 200, height: 44)
                        )
                        .cornerRadius(40)
                }
                .buttonStyle(.plain)
                */
                
                Button {
                    // 埋点：点击 Show 3D 按钮
                    let username = model.userData?.username ?? "idle"
                    TrackEvents.buttonClick.record(username: username,
                                                   pagePath: "floor/detail",
                                                   extraInfo: "show3d",
                                                   productName: model.currentDetailItem?.name)

                    Task { @MainActor in
                        switch appModel.modelFullSpaceState {
                        case .open:
                            appModel.modelFullSpaceState = .inTransition
                            await dismissImmersiveSpace()
                            // Don't set immersiveSpaceState to .closed because there
                            // are multiple paths to ImmersiveView.onDisappear().
                            // Only set .closed in ImmersiveView.onDisappear().
                            
                        case .closed:
                            appModel.modelFullSpaceState = .inTransition
                            switch await openImmersiveSpace(id: appModel.modelFullSpaceID) {
                            case .opened:
                                // Don't set immersiveSpaceState to .open because there
                                // may be multiple paths to ImmersiveView.onAppear().
                                // Only set .open in ImmersiveView.onAppear().
                                break
                            case .userCancelled, .error:
                                // On error, we need to mark the immersive space
                                // as closed because it failed to open.
                                fallthrough
                            @unknown default:
                                // On unknown response, assume space did not open.
                                appModel.modelFullSpaceState = .closed
                            }
                        case .inTransition:
                            // This case should not ever happen because button is disabled for this case.
                            break
                        }
                    }
                } label: {
                    Text("Show 3D")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Color(red: 42.0/255, green: 68.0/255, blue: 75.0/255))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(
                            Color(red: 213.0/255, green: 213.0/255, blue: 0)
                        )
                        .cornerRadius(40)
                }
                .buttonStyle(.plain)
                
                if let _ = model.userData {
                    
                    Button {
                        let username = model.userData?.username ?? "idle"

                        if isHeartFilled {
                            // 埋点：取消收藏
                            TrackEvents.removeFavorite.record(username: username,
                                                              pagePath: "floor/detail",
                                                              productName: model.currentDetailItem?.name)
                            if let itemId = model.currentDetailItem?.id,
                               let favoriteItem = model.getFavoriteItem(itemId)  {
                                let favoriteItemId = favoriteItem.favoriteData.id
                                let deleteRequest = FavoriteDeleteRequest(id: favoriteItemId)
                                HttpClient.shared.deleteFavorite(request: deleteRequest) { result in
                                    switch result {
                                    case .success():
                                        print("✅ User delete favorite successful!")
                                        Task { @MainActor in
                                            isHeartFilled = false
                                            // 更新 favorite items
                                            model.fetchFavoriteItems { success, error in
                                                if !success {
                                                    print("❌ Fetch favorite items failed! error message: \(String(describing: error))")
                                                }
                                            }
                                        }
                                    case .failure(let error):
                                        print("❌ User delete favorite failed! error message: \(String(describing: error.errorDescription))")
                                    }
                                }
                            }
                             
                        } else {
                            // 埋点：添加收藏
                            TrackEvents.addFavorite.record(username: username,
                                                          pagePath: "floor/detail",
                                                          productName: model.currentDetailItem?.name)
                            let username = model.userData?.username ?? ""
                            let productId = model.currentProduct?.productId ?? 1
                            let itemId = model.currentDetailItem?.id ?? 1
                            let generalItem = PGeneralItemInfo(productId: productId, itemId: itemId)
                            let jsonStr = generalItem.toJsonString() ?? "{}"
                            let request = FavoriteCreateRequest(username: username, productInfo: jsonStr)
                            HttpClient.shared.addFavorite(request: request) { result in
                                switch result {
                                case .success(let userResponse):
                                    print("✅ User add favorite successful!  response: \n \(userResponse)")
                                    Task { @MainActor in
                                        isHeartFilled = true
                                        // 更新 favorite items
                                        model.fetchFavoriteItems { success, error in
                                            if !success {
                                                print("❌ Fetch favorite items failed! error message: \(String(describing: error))")
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    print("❌ User add favorite failed! error message: \(String(describing: error.errorDescription))")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: isHeartFilled ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 8)
                    }
                    .buttonStyle(.plain)
                    
                } else {
                    Button {
                        showLoginPopup.toggle()
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 8)
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showLoginPopup) {
                        VStack(alignment: .center, spacing: 8) {
                            Image("favorite_not_login_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 52, height: 52)
                            
                            Text("Save the item to your own list.")
                                .font(.system(size: 15))
                                .foregroundStyle(.white.opacity(0.23))
                                .frame(height: 36)
                            
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 280, height: 1)
                            
                            Button {
                                // TODO: 处理登录逻辑
                                showLoginPopup = false
                                
                                Task { @MainActor in
                                    model.accountPath.removeAll()
                                    model.accountPath.append(.login)
                                    model.selectedTab = .profile
                                }
                                
                            } label: {
                                Text("Log In")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.96))
                                    .frame(height: 44)
                                    .padding(.horizontal, 20)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(20)
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
            .glassBackgroundEffect()
        }
        .onAppear {
            if let itemId = model.currentDetailItem?.id {
                isHeartFilled = model.isFavoriteItem(itemId)
            } else {
                isHeartFilled = false
            }

            // 埋点：进入 FloorDetail
            let username = model.userData?.username ?? "idle"
            let productName = model.currentDetailItem?.name
            TrackEvents.floorDetailEnter.record(username: username,
                                               pagePath: "floor/detail",
                                               productName: productName)
        }
        .onDisappear {
            // 埋点：离开 FloorDetail
            let username = model.userData?.username ?? "idle"
            let productName = model.currentDetailItem?.name
            TrackEvents.floorDetailExit.record(username: username,
                                               pagePath: "floor/detail",
                                               productName: productName)
        }
    }
    
    func closeImmersiveSpace() async {
        if appModel.modelFullSpaceState == .open {
            appModel.modelFullSpaceState = .inTransition
            await dismissImmersiveSpace()
        }
    }
}


// MARK: - aux
struct FloorDetailStripe: View {
    
    @State var showDetail: Bool = false
    var name: String = "SPECS"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: {
                withAnimation {
                    showDetail.toggle()
                }
            }) {
                HStack {
                    Text(name)
                        .font(
                            Font.custom("Poppins", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.white.opacity(0.96))
                    Spacer()
                    
                    Group {
                        if showDetail {
                            Image(systemName: "chevron.down" )
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName:  "chevron.forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .foregroundColor(.white.opacity(0.96))
                    .frame(width: 16, height: 16)
                    .background(
                        Color.clear.contentShape(Rectangle())
                            .frame(width: 40, height: 40)
                    )
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
            }.buttonStyle(PlainButtonStyle())
            
            if showDetail {
                Group {
                    if name == "SPECS" {
//                        SpecsStripeInfo()
//                            .frame(maxWidth: .infinity)
                        SpecsStripeInfo2()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Upcoming...")
                            .font(
                                Font.custom("Poppins", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(.white.opacity(0.96))
                    }
                }
                .padding(.horizontal, 8)
            }
            
            Divider()
        }
    }
}

struct SpecsStripeInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // Material
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image("materialIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("Material")
                        .font(
                            Font.custom("Poppins", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.white.opacity(0.96))
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    LazyVGrid(columns: [
                        GridItem(.fixed(180)),
                        GridItem(.fixed(180))
                    ], alignment: .leading, spacing: 16) {
                        ForEach(materialData) { data in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(data.key)
                                    .font(
                                        Font.custom("Poppins", size: 16)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white.opacity(0.96))
                                    .underline()
                                
                                Text(data.value)
                                    .font(
                                        Font.custom("Poppins", size: 16)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white.opacity(0.96))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: 180, alignment: .leading)
                        }
                    }
                }
                .frame(maxWidth: 380)
            }
            
            // Craft
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image("craftIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("Craftsmanship")
                        .font(
                            Font.custom("Poppins", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.white.opacity(0.96))
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    LazyVGrid(columns: [
                        GridItem(.fixed(180)),
                        GridItem(.fixed(180))
                    ], alignment: .leading, spacing: 16) {
                        ForEach(craftData) { data in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(data.key)
                                    .font(
                                        Font.custom("Poppins", size: 16)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white.opacity(0.96))
                                    .underline()
                                
                                Text(data.value)
                                    .font(
                                        Font.custom("Poppins", size: 16)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white.opacity(0.96))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: 180, alignment: .leading)
                        }
                    }
                }
                .frame(maxWidth: 380)
            }
            
            // DIMENSIONS
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image("dimensionIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("DIMENSIONS")
                        .font(
                            Font.custom("Poppins", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.white.opacity(0.96))
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    LazyVGrid(columns: [
                        GridItem(.fixed(180)),
                        GridItem(.fixed(180))
                    ], alignment: .leading, spacing: 16) {
                        ForEach(dimensionData) { data in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(data.key)
                                    .font(
                                        Font.custom("Poppins", size: 16)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white.opacity(0.96))
                                    .underline()
                                
                                Text(data.value)
                                    .font(
                                        Font.custom("Poppins", size: 16)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white.opacity(0.96))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: 180, alignment: .leading)
                        }
                    }
                }
                .frame(maxWidth: 380)
            }
        }
    }
}

struct SpecsStripeInfo2: View {
    
    @Environment(AppModel.self) private var appModel
    var body: some View {
        if let specs = appModel.currentDetailItem?.Specs {
            VStack(alignment: .leading, spacing: 24) {
                // Material
                getSingleStripeView(specs[0])
                // Craft
                getSingleStripeView(specs[1])
                // Dimension
                getSingleStripeView(specs[2])
            }
        } else {
            Text("No Specs Data")
        }
    }
    
    private func getSingleStripeView(_ moduleInfo: PItemDetailModuleInfo) -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(moduleInfo.icon) // materialIcon craftIcon dimensionIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(moduleInfo.module)
                    .font(
                        Font.custom("Poppins", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.white.opacity(0.96))
            }
            
            VStack(alignment: .leading, spacing: 16) {
                LazyVGrid(columns: [
                    GridItem(.fixed(180)),
                    GridItem(.fixed(180))
                ], alignment: .leading, spacing: 16) {
                    ForEach(moduleInfo.subs, id: \.self.position) { data in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(data.name)
                                .font(
                                    Font.custom("Poppins", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white.opacity(0.96))
                                .underline()
                            
                            Text(data.desc)
                                .font(
                                    Font.custom("Poppins", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white.opacity(0.96))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: 180, alignment: .leading)
                    }
                }
            }
            .frame(maxWidth: 380)
        }
//        return Text("")
    }
}

// MARK: - stripe data
struct StripeInfoSingleData: Identifiable {
    let id: UUID = UUID()
    var key: String = ""
    var value: String = ""
}

let materialData: [StripeInfoSingleData] = [
    .init(key: "Species", value: "European Oak"),
    .init(key: "Grade", value: "ABC"),
    .init(key: "Core & Back", value: "Hardwood Plywood"),
    .init(key: "Edges", value: "Micro-beveled"),
]

let craftData: [StripeInfoSingleData] = [
    .init(key: "Finish", value: "UV Lacquer"),
    .init(key: "Treatment", value: "Smoked"),
    .init(key: "Texture", value: "Wire Brushed"),
    .init(key: "Profiling", value: "Tongue & Groove, with four side bevel , 1.2mm bevel on long-sides + 0.2mm bevel on short sides."),
    .init(key: "Adhesive", value: "Top layer lamination: Formaldehyde - Free.\nProduct contains No Added Urea Formaldehyde (NAUF).\nCARB ATCM Phase II Compliant ( < 0.05 PPM Formaldehyde)"),
]

let dimensionData: [StripeInfoSingleData] = [
    .init(key: "Length", value: "86-5/8\" with 25% two strips per carton"),
    .init(key: "Top Layer Thickness", value: "4mm"),
    .init(key: "Thickness", value: "18mm"),
    .init(key: "Plank Width", value: "8-5/8\""),
]


//#Preview {
//    FloorDetail()
//}
