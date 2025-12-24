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
    
    // XR Floor Replacement
    let xrFloorReplacementID = "XRFloorReplacement"
    enum XRFloorReplacementState {
        case closed
        case inTransition
        case open
    }
    var xrFloorReplacementState = XRFloorReplacementState.closed

    // XR Room Scanner (Phase-based scanning)
    let xrRoomScannerID = "XRRoomScanner"
    enum XRRoomScannerState {
        case closed
        case inTransition
        case open
    }
    var xrRoomScannerState = XRRoomScannerState.closed

    // Model Viewer (for viewing scanned USDZ rooms)
    let modelViewerID = "ModelViewer"
    enum ModelViewerState {
        case closed
        case inTransition
        case open
    }
    var modelViewerState = ModelViewerState.closed

    var isXRModeActive: Bool = false
    var detectedRoomArea: Float = 0
    
    // MARK: - Configuration
    /// Configuration-based mock data usage
    /// This property reflects the AppConfiguration setting and should not be manually changed
    var useMockData: Bool {
        return AppConfiguration.enableMockData
    }
    
    /// Get current configuration summary for debugging
    func getConfigurationSummary() -> String {
        return """
        📋 App Configuration Summary:
           Environment: \(AppConfiguration.developmentModeDescription)
           Build: \(AppConfiguration.buildConfiguration)
           Mock Data: \(AppConfiguration.enableMockData ? "ENABLED" : "DISABLED")
           Debug Logging: \(AppConfiguration.enableDebugLogging ? "ENABLED" : "DISABLED")
           Network Logging: \(AppConfiguration.enableNetworkLogging ? "ENABLED" : "DISABLED")
           Analytics: \(AppConfiguration.enableAnalytics ? "ENABLED" : "DISABLED")
           Crash Reporting: \(AppConfiguration.enableCrashReporting ? "ENABLED" : "DISABLED")
        """
    }
    
    /// Print configuration to console (development only)
    func printConfiguration() {
        if AppConfiguration.enableDebugLogging {
            AppConfiguration.printConfiguration()
            print(getConfigurationSummary())
        }
    }
    
    // data
    var productList: [Product] = []
    var itemList: [PItem] = []
    var currentProduct: Product? = nil
    var currentDetailItem: PItemDetail? = nil
    var currentFloorAsset: String = "Novara_floor"
//    var currentItem: PItem? = nil
    // Commented out problematic init code for crash testing
    /*
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
    */
    
    // Enhanced init with configuration management
    init() {
        print("📱 AppModel: Initializing with AppConfiguration integration")
        
        // Set basic defaults to prevent crashes
        hasLaunched = false
        
        // Print configuration summary in development
        printConfiguration()
        
        // Log current environment
        if AppConfiguration.enableDebugLogging {
            print("🔧 Development Mode: Mock data automatically \(AppConfiguration.enableMockData ? "ENABLED" : "DISABLED")")
            print("🌐 Production Mode: Would use real API with \(AppConfiguration.baseURL)")
        }
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
            if AppConfiguration.enableDebugLogging {
                print("✅ Loaded \(res.productList.count) products from local JSON")
            }
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
            if AppConfiguration.enableDebugLogging {
                print("✅ Loaded \(res.itemList.count) item categories from local JSON")
            }
//            print("AppModel: itemList -> \(self.itemList[0].items[0].Specs.count)")
        } catch {
            assertionFailure("import json file error \(error.localizedDescription)")
        }
    }
    
    /// 获取经销商列表
    func fetchDistributorList() {
        // Check if we should use mock data based on AppConfiguration
        if AppConfiguration.enableMockData || ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] != nil {
            if AppConfiguration.enableDebugLogging {
                print("🔧 Using mock distributors (config: \(AppConfiguration.enableMockData), simulator: \(ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] != nil))")
            }
            self.distributors = createMockDistributors()
            if self.currentDistributor == nil && !self.distributors.isEmpty {
                self.currentDistributor = self.distributors[0]
            }
            return
        }
        
        // Use real API for production
        if AppConfiguration.enableNetworkLogging {
            print("🌐 Using real API for distributor data from \(AppConfiguration.baseURL)")
        }
        let queryRequest = DealerQueryRequest(pageSize: 100)
        HttpClient.shared.getDealerList(query: queryRequest) { result in
            switch result {
            case .success(let pageResponse):
                if AppConfiguration.enableNetworkLogging {
                    print("✅ User getDealerList successful!  response: \n \(pageResponse)")
                }
                self.distributors = pageResponse.list
                // Auto-select first if none selected
                if self.currentDistributor == nil && !self.distributors.isEmpty {
                    self.currentDistributor = self.distributors[0]
                }
            case .failure(let error):
                if AppConfiguration.enableNetworkLogging {
                    print("❌ User getDealerList failed! error message: \(String(describing: error.errorDescription))")
                }
                // Fallback to mock data on error
                print("🔧 Falling back to mock distributors due to API error")
                self.distributors = self.createMockDistributors()
                if self.currentDistributor == nil && !self.distributors.isEmpty {
                    self.currentDistributor = self.distributors[0]
                }
            }
        }
    }
    
    /// Create mock distributors for development/testing
    private func createMockDistributors() -> [DealerResponse] {
        // Create mock distributors matching your DealerResponse structure
        let currentTime = ISO8601DateFormatter().string(from: Date())
        return [
            DealerResponse(
                id: 1,
                name: "O4H Flagship Store - SF",
                code: "O4H-SF-001",
                email: "flagship@o4h.com",
                phone: "+1 (415) 555-0001",
                address: "123 Market St, San Francisco, CA 94103",
                description: "Flagship store in downtown San Francisco",
                status: 1,
                statusText: "Active",
                createTime: currentTime,
                updateTime: currentTime
            ),
            DealerResponse(
                id: 2,
                name: "O4H Downtown - SF",
                code: "O4H-SF-002",
                email: "downtown@o4h.com",
                phone: "+1 (415) 555-0002",
                address: "456 Mission St, San Francisco, CA 94105",
                description: "Downtown location",
                status: 1,
                statusText: "Active",
                createTime: currentTime,
                updateTime: currentTime
            ),
            DealerResponse(
                id: 3,
                name: "O4H Valley - SF",
                code: "O4H-SF-003",
                email: "valley@o4h.com",
                phone: "+1 (415) 555-0003",
                address: "789 Valencia St, San Francisco, CA 94110",
                description: "Mission Valley location",
                status: 1,
                statusText: "Active",
                createTime: currentTime,
                updateTime: currentTime
            )
        ]
    }
    
    /// 获取用户收藏项数据
    /// - Parameter completion: 完成回调，参数为是否成功和错误信息
    func fetchFavoriteItems(completion: ((Bool, String?) -> Void)? = nil) {
        guard let username = userData?.username else {
            completion?(false, "User not logged in")
            return
        }
        
        if AppConfiguration.enableDebugLogging {
            print("AppModel: Welcome back, \(username)!")
        }
        let requset = FavoriteQueryRequest(username: username, pageSize: 200)
        HttpClient.shared.getUserFavorites(query: requset) { result in
            switch result {
            case .success(let favoriteDataArray):
                if AppConfiguration.enableDebugLogging {
                    print("✅ User getUserFavorite successful!  response: \n \(favoriteDataArray)")
                }
                self.favoriteDatas = favoriteDataArray
                self.setupFavoriteItems()
                completion?(true, nil)
            case .failure(let error):
                if AppConfiguration.enableDebugLogging {
                    print("❌ User getUserFavorite failed! error message: \(String(describing: error.errorDescription))")
                }
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
        
        if AppConfiguration.enableDebugLogging {
            print("AppModel: setupFavoriteItems - Successfully loaded \(favoriteItems.count) favorite items")
        }
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
                // CRITICAL FIX: Use material name for immersive space USDZ models
                // The USDZ floor models in RealityKitContent should match material names
                self.currentFloorAsset = materialName
                print("Switched floor asset to: \(materialName) (for immersive space USDZ loading)")
            } else {
                assertionFailure("AppModel: materials does not contain key \(bakeKey)")
                self.currentFloorAsset = "Novara_floor"
            }
        print("Current floor item asset: \(item.asset)")
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
    
    var currentCabinetMaterial: CabinetMaterial = .default
    var availableCabinetMaterials: [CabinetMaterial] = [
        .default,
        .whiteMatte,
        .woodGrain,
        .darkWalnut,
        .grayModern
    ]
    
    
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
