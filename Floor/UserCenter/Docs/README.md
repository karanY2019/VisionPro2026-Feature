# VR后端项目 Swift HTTP客户端

这是一个基于URLSession的专业HTTP客户端实现，用于与VR后端项目的REST API进行通信。

## 文件结构

```
UserCenter/
├── HttpClient.swift          # 主要的HTTP客户端类
├── NetworkModels.swift       # 基础网络模型和错误处理
├── UserModels.swift         # 用户相关的请求/响应模型
├── ProductModels.swift      # 产品相关的请求/响应模型
├── FavoriteModels.swift     # 收藏相关的请求/响应模型
├── TrackModels.swift        # 用户行为追踪相关的请求/响应模型
├── StatisticsModels.swift   # 统计数据相关的请求/响应模型
├── HttpClientExample.swift  # 使用示例
└── README.md               # 文档说明
```

## 特性

- ✅ 单例模式设计，全局访问
- ✅ 基于URLSession的原生网络请求
- ✅ 统一的错误处理机制
- ✅ 泛型支持，类型安全
- ✅ 自动JSON序列化/反序列化
- ✅ 支持国际化（i18n）
- ✅ 完整的API覆盖
- ✅ 友好的接口设计
- ✅ 详细的使用示例

## 快速开始

### 1. 配置基础URL

在`HttpClient.swift`中修改`baseURL`为您的实际API地址：

```swift
self.baseURL = "https://your-api-domain.com/api"
```

### 2. 基本使用

```swift
import Foundation

// 获取HttpClient实例
let httpClient = HttpClient.shared

// 用户登录
httpClient.userLogin(userCode: "USER_CODE_123") { result in
    switch result {
    case .success(let user):
        print("登录成功: \(user.username)")
    case .failure(let error):
        print("登录失败: \(error.localizedDescription)")
    }
}
```

## API 使用示例

### 用户管理

```swift
// 用户登录
httpClient.userLogin(userCode: "USER_CODE_123") { result in
    switch result {
    case .success(let user):
        print("用户: \(user.username), 邮箱: \(user.email)")
    case .failure(let error):
        print("错误: \(error.localizedDescription)")
    }
}

// 获取用户列表
let query = UserQueryRequest(pageNum: 1, pageSize: 10)
httpClient.getUserList(query: query) { result in
    switch result {
    case .success(let pageResponse):
        print("总数: \(pageResponse.total)")
        for user in pageResponse.list {
            print("用户: \(user.username)")
        }
    case .failure(let error):
        print("错误: \(error.localizedDescription)")
    }
}

// 创建用户
let createRequest = UserCreateRequest(username: "张三", email: "zhangsan@example.com", dealerId: 1)
httpClient.createUser(request: createRequest) { result in
    switch result {
    case .success(let user):
        print("用户创建成功，用户码: \(user.userCode)")
    case .failure(let error):
        print("创建失败: \(error.localizedDescription)")
    }
}
```

### 产品管理

```swift
// 获取产品列表
let productQuery = ProductQueryRequest(pageNum: 1, pageSize: 20, name: "VR眼镜")
httpClient.getProductList(query: productQuery) { result in
    switch result {
    case .success(let pageResponse):
        for product in pageResponse.list {
            print("产品: \(product.name) - \(product.description)")
        }
    case .failure(let error):
        print("错误: \(error.localizedDescription)")
    }
}

// 获取启用的产品
httpClient.getEnabledProducts { result in
    switch result {
    case .success(let products):
        print("可用产品数量: \(products.count)")
    case .failure(let error):
        print("错误: \(error.localizedDescription)")
    }
}
```

### 收藏管理

```swift
// 添加收藏
let favoriteRequest = FavoriteCreateRequest(
    userCode: "USER_CODE_123",
    productName: "VR眼镜Pro",
    sourcePage: "/products"
)
httpClient.addFavorite(request: favoriteRequest) { result in
    switch result {
    case .success(let favorite):
        print("收藏成功: \(favorite.productName)")
    case .failure(let error):
        print("收藏失败: \(error.localizedDescription)")
    }
}

// 获取用户收藏
httpClient.getUserFavorites(userCode: "USER_CODE_123") { result in
    switch result {
    case .success(let favorites):
        print("收藏数量: \(favorites.count)")
        for favorite in favorites {
            print("收藏: \(favorite.productName)")
        }
    case .failure(let error):
        print("错误: \(error.localizedDescription)")
    }
}

// 检查是否已收藏
httpClient.checkFavorited(userCode: "USER_CODE_123", productName: "VR眼镜Pro") { result in
    switch result {
    case .success(let isFavorited):
        print("是否已收藏: \(isFavorited)")
    case .failure(let error):
        print("检查失败: \(error.localizedDescription)")
    }
}
```

### 用户行为追踪

```swift
// 记录用户行为
let trackRequest = TrackCreateRequest(
    userCode: "USER_CODE_123",
    eventName: "page_view",
    trackData: "产品详情页",
    pagePath: "/product/123",
    extraInfo: "VR应用追踪"
)
httpClient.recordTrack(request: trackRequest) { result in
    switch result {
    case .success(let success):
        if success {
            print("行为记录成功")
        }
    case .failure(let error):
        print("记录失败: \(error.localizedDescription)")
    }
}

// 记录会话时间
httpClient.recordSessionTrack(
    userCode: "USER_CODE_123",
    eventName: "session_time",
    sessionTime: 1800, // 30分钟
    pagePath: "/immersive"
) { result in
    switch result {
    case .success:
        print("会话时间记录成功")
    case .failure(let error):
        print("记录失败: \(error.localizedDescription)")
    }
}
```

### 统计数据

```swift
// 获取全部统计数据
httpClient.getAllStatistics { result in
    switch result {
    case .success(let stats):
        print("总客户数: \(stats.totalCustomers)")
        print("平均会话时间: \(stats.averageSessionTime)秒")
        print("最受欢迎产品: \(stats.mostViewedProduct)")
        print("最受喜爱产品: \(stats.mostFavoritedProduct)")
    case .failure(let error):
        print("获取统计失败: \(error.localizedDescription)")
    }
}

// 获取筛选后的统计数据
let statsRequest = StatisticsRequest(
    startTime: "2023-01-01T00:00:00",
    endTime: "2023-12-31T23:59:59",
    dealerId: 1
)
httpClient.getStatistics(request: statsRequest) { result in
    switch result {
    case .success(let stats):
        print("筛选后的统计数据: \(stats.totalCustomers)个客户")
    case .failure(let error):
        print("获取失败: \(error.localizedDescription)")
    }
}
```

## 错误处理

系统提供了完整的错误处理机制：

```swift
enum NetworkError: Error {
    case invalidURL          // 无效URL
    case noData             // 无数据
    case encodingError(Error)  // 编码错误
    case decodingError(Error)  // 解码错误
    case networkError(Error)   // 网络错误
    case invalidResponse     // 无效响应
    case apiError(Int, String) // API错误（状态码，消息）
}
```

## 模型结构

所有API响应都遵循统一格式：

```swift
struct ApiResponse<T: Codable>: Codable {
    let code: Int           // 状态码
    let message: String     // 响应消息
    let data: T?           // 数据内容
    let timestamp: TimeInterval // 时间戳
}
```

### 分页响应

```swift
struct PageResponse<T: Codable>: Codable {
    let list: [T]          // 数据列表
    let total: Int         // 总数
    let pageNum: Int       // 当前页
    let pageSize: Int      // 页大小
    let pages: Int?        // 总页数
    // ... 其他分页信息
}
```

## 注意事项

1. **单例使用**: HttpClient使用单例模式，通过`HttpClient.shared`访问
2. **异步回调**: 所有网络请求都在主线程回调
3. **错误处理**: 建议对所有网络请求都进行适当的错误处理
4. **国际化**: 自动根据系统语言设置Accept-Language头
5. **超时设置**: 默认请求超时30秒，资源超时60秒

## 自定义配置

可以通过修改HttpClient的初始化来自定义配置：

```swift
// 在HttpClient.swift的init方法中修改
let config = URLSessionConfiguration.default
config.timeoutIntervalForRequest = 30    // 请求超时时间
config.timeoutIntervalForResource = 60   // 资源超时时间
```

## 扩展新接口

添加新接口只需要：

1. 在对应的Models文件中定义请求/响应结构体
2. 在HttpClient中添加对应的方法
3. 按照现有模式实现网络请求

示例：

```swift
// 1. 在相应Models文件中定义
struct NewRequest: Codable {
    let param: String
}

struct NewResponse: Codable {
    let result: String
}

// 2. 在HttpClient中添加方法
func newApiCall(request: NewRequest, completion: @escaping (Result<NewResponse, NetworkError>) -> Void) {
    self.request(endpoint: "/new-endpoint", requestBody: request, responseType: NewResponse.self) { result in
        switch result {
        case .success(let response):
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(.noData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
```

## 许可证

本项目采用 MIT 许可证。 