import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    let secondImmersiveSpaceID = "SecondImmersiveSpace"
    
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    var selectedTab: BizTab = .home
    
    var navigationPath: [Router] = []
    var accountPath: [AccountPath] = []
    
    // Track navigation context for FloorDetail
    var detailNavigationContext: QueryDetailPath = .normal
    
    // ModelView
    let modelFullSpaceID = "ModelFullSpace"
    enum ModelFullSpaceState {
        case closed
        case inTransition
        case open
    }
    var modelFullSpaceState = ModelFullSpaceState.closed

    // WelcomeView
    let welcomeViewID = "WelcomeView"
    enum WelcomeViewState {
        case closed
        case inTransition
        case open
    }
    var welcomeViewState = WelcomeViewState.closed
    
    // LaunchSpace
    let launchSpaceID = "LaunchSpace"
    enum LaunchSpaceState {
        case closed
        case inTransition
        case open
    }
    var launchSpaceState = LaunchSpaceState.closed
    
    var hasLaunched: Bool = false
    
    // data
    var productList: [Product] = []
    var itemList: [PItem] = []
    var currentProduct: Product? = nil
    var currentDetailItem: PItemDetail? = nil
    var currentFloorAsset: String = "Novara_floor"
//    var currentItem: PItem? = nil
    init() {
        // Initialize currentDistributor from UserDefaults
        if let distributorData = UserDefaults.standard.data(forKey: "AppModel.currentDistributor"),
           let decodedDistributor = try? JSONDecoder().decode(DealerResponse.self, from: distributorData) {
            self.currentDistributor = decodedDistributor
        }
        
        // 从本地存储恢复 userData
        if let userDataData = UserDefaults.standard.data(forKey: "AppModel.userData") {
            if let decodedUserData = try? JSONDecoder().decode(UserResponse.UserData.self, from: userDataData) {
                self.userData = decodedUserData
            }
        }
        
        fetchProductData()
        fetchDistributorList()
        fetchFavoriteItems()
    }
    
    func fetchProductData() {
        guard let url = Bundle.main.url(forResource: "productList", withExtension: "json") else {
            print("AppModel: productList.json not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let res = try decoder.decode(ProductListResponse.self, from: data)
            self.productList = res.productList
//            print("AppModel: productList -> \(self.productList)")
        } catch {
            assertionFailure("import json file error \(error.localizedDescription)")
        }
        
        guard let url = Bundle.main.url(forResource: "itemList", withExtension: "json") else {
            print("AppModel: itemList.json not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let res = try decoder.decode(ItemListResponse.self, from: data)
            self.itemList = res.itemList
//            print("AppModel: itemList -> \(self.itemList[0].items[0].Specs.count)")
        } catch {
            assertionFailure("import json file error \(error.localizedDescription)")
        }
    }
    
    /// 获取经销商列表
    func fetchDistributorList() {
        
        let queryRequest = DealerQueryRequest(pageSize: 100)
        HttpClient.shared.getDealerList(query: queryRequest) { result in
            switch result {
            case .success(let pageResponse):
                print("✅ User getDealerList successful!  response: \n \(pageResponse)")
                self.distributors = pageResponse.list
            case .failure(let error):
                print("❌ User getUserFavorite failed! error message: \(String(describing: error.errorDescription))")
            }
        }
        
    }
    
    /// 获取用户收藏项数据
    /// - Parameter completion: 完成回调，参数为是否成功和错误信息
    func fetchFavoriteItems(completion: ((Bool, String?) -> Void)? = nil) {
        guard let username = userData?.username else {
            completion?(false, "User not logged in")
            return
        }
        
        print("AppModel: Welcome back, \(username)!")
        let requset = FavoriteQueryRequest(username: username, pageSize: 200)
        HttpClient.shared.getUserFavorites(query: requset) { result in
            switch result {
            case .success(let favoriteDataArray):
                print("✅ User getUserFavorite successful!  response: \n \(favoriteDataArray)")
                self.favoriteDatas = favoriteDataArray
                self.setupFavoriteItems()
                completion?(true, nil)
            case .failure(let error):
                print("❌ User getUserFavorite failed! error message: \(String(describing: error.errorDescription))")
                completion?(false, error.errorDescription)
            }
        }
    }
    
    private func setupFavoriteItems() {
        favoriteItems = []
        
        for favoriteData in favoriteDatas {
            // 从productInfo中解析出PGeneralItemInfo
            guard let generalInfo = favoriteData.generalInfo else {
                print("AppModel: setupFavoriteItems - Failed to parse generalInfo from favoriteData id: \(favoriteData.id)")
                continue
            }
            
            // 根据productId在itemList中查找对应的PItem
            guard let matchedPItem = itemList.first(where: { $0.productId == generalInfo.productId }) else {
                print("AppModel: setupFavoriteItems - Product not found for productId: \(generalInfo.productId)")
                continue
            }
            
            // 根据itemId在该PItem的items中查找对应的PItemDetail
            guard let matchedItemDetail = matchedPItem.items.first(where: { $0.id == generalInfo.itemId }) else {
                print("AppModel: setupFavoriteItems - Item not found for itemId: \(generalInfo.itemId) in productId: \(generalInfo.productId)")
                continue
            }
            
            // 构造PFavoriteItemInfo对象
            let favoriteItemInfo = PFavoriteItemInfo(
                favoriteData: favoriteData,
                detailInfo: matchedItemDetail
            )
            
            favoriteItems.append(favoriteItemInfo)
        }
        
        print("AppModel: setupFavoriteItems - Successfully loaded \(favoriteItems.count) favorite items")
    }
    
    func updateCurrentProduct(_ type: ProductType) {
        guard let product = productList.first(where: { $0.type == type }) else {
            assertionFailure("AppModel: updateCurrentProduct failed, type not found \(type)")
            return
        }
        self.currentProduct = product
    }
    
    func updateCurrentDetailItem(_ id: Int) {
        guard let item = currentItems.first(where: { $0.id == id }) else {
            assertionFailure("AppModel: updateCurrentDetailItem failed, id not found \(id)")
            return
        }
        self.currentDetailItem = item
        let bakeKey = isHideFurniture ? "unbaked" : "baked"
            if let materialName = item.materials[bakeKey] {
                self.currentFloorAsset = materialName
                print("Switched floor asset to: \(materialName)")
            } else {
                assertionFailure("AppModel: materials does not contain key \(bakeKey)")
                self.currentFloorAsset = "Novara_floor"
            }
        print("Switched floor asset to: \(item.asset)")
    }
    
    func updateCurrentDetailItemFromAllProducts(_ id: Int) {
        // Search across all products to find the item
        for productItem in itemList {
            if let item = productItem.items.first(where: { $0.id == id }) {
                self.currentDetailItem = item
                let bakeKey = isHideFurniture ? "unbaked" : "baked"
                    if let materialName = item.materials[bakeKey] {
                        self.currentFloorAsset = materialName
                        print("Switched floor asset to: \(materialName)")
                    } else {
                        assertionFailure("AppModel: materials does not contain key \(bakeKey)")
                        self.currentFloorAsset = "Novara_floor"
                    }
                print("Switched floor asset to: \(item.asset)")
                return
            }
        }
        assertionFailure("AppModel: updateCurrentDetailItemFromAllProducts failed, id not found \(id)")
    }
    
    var currentItems: [PItemDetail] {
        guard let currentProduct = currentProduct else {
            return []
        }
        return itemList.filter { $0.type == currentProduct.type }.first?.items ?? []
    }
    
    var isMainWindowVisible: Bool = true
    var isDecorationVisible: Bool = false
    var isLayoutPageVisible: Bool = false
    var isClearEntities: Bool = false
    var isClearEntitiesForRoom2: Bool = false
    var selectedWall: String = "Wall_A"
    var currentImmersiveSpaceID: String = "SecondImmersiveSpace"
    var currentColorCard: String = "Emerald Designer"
    var currentWallStyle: String = "All"
    var currentWallColorHex: String = "#FFFFFF"
    var currentSelectedColor: PaintColor? = PaintColor(
        colorName: "Radiant Dawn",
        colorID: "SW9661",
        hex: "EBE0CE"
    )
    var selectedStyle: Int = 0
    var isHideFurniture: Bool = false
    
    // MARK: - UserCenter
    // 后端通信的PGeneralItemInfo
    var favoriteDatas: [FavoriteResponse.FavoriteData] = []
    var favoriteItems: [PFavoriteItemInfo] = []
//    var distributors: [String] =  ["O4H Flagship, SF", "O4H Downtown, SF", "O4H Valley, SF"]
    var distributors: [DealerResponse] =  []
    var currentDistributor: DealerResponse? = nil {
        didSet {
            if let distributor = currentDistributor {
                if let encoded = try? JSONEncoder().encode(distributor) {
                    UserDefaults.standard.set(encoded, forKey: "AppModel.currentDistributor")
                }
            } else {
                // 如果设置为 nil，则从本地存储中删除
                UserDefaults.standard.removeObject(forKey: "AppModel.currentDistributor")
            }
        }
    }
    
    var userData: UserResponse.UserData? = nil {
        didSet {
            // 保存到本地存储
            if let userData = userData {
                if let encoded = try? JSONEncoder().encode(userData) {
                    UserDefaults.standard.set(encoded, forKey: "AppModel.userData")
                }
            } else {
                // 如果设置为 nil，则从本地存储中删除
                UserDefaults.standard.removeObject(forKey: "AppModel.userData")
            }
        }
    }
    
    func isFavoriteItem(_ itemId: Int) -> Bool {
        for favoriteItem in favoriteItems {
            if favoriteItem.detailInfo.id == itemId {
                return true
            }
        }
        return false
    }
    
    func getFavoriteItem(_ itemId: Int) -> PFavoriteItemInfo? {
        for favoriteItem in favoriteItems {
            if favoriteItem.detailInfo.id == itemId {
                return favoriteItem
            }
        }
        return nil
    }
}
