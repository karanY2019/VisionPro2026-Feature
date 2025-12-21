//
//  TrackEvents.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/7/14.
//

import Foundation

enum TrackEvents: String, CaseIterable {
    // 应用生命周期
    case appLaunch = "app_launch"
    case appBackground = "app_background"
    case appForeground = "app_foreground"
    
    // 用户行为
    case userLogin = "user_login"
    case userLogout = "user_logout"
    case userRegister = "user_register"
    
    // 页面浏览
    case pageView = "page_view"
    case categoryView = "category_view"
    case productView = "product_view"
    case welcomeView = "welcome_view"
    case homeViewEnter = "home_view_enter"
    case homeViewExit = "home_view_exit"
    case floorViewEnter = "floor_view_enter"
    case floorViewExit = "floor_view_exit"
    case floorDetailEnter = "floor_detail_enter"
    case floorDetailExit = "floor_detail_exit"
    case modelViewEnter = "model_view_enter"
    case modelViewExit = "model_view_exit"
    
    // 交互事件
    case buttonClick = "button_click"
    case floorSelect = "floor_select"
    case roomChange = "room_change"
    case styleChange = "style_change"
    
    // 布局选择
    case styleSelect = "style_select"
    
    // 搜索相关
    case search = "search"
    case searchResult = "search_result"
    
    // 收藏相关
    case addFavorite = "add_favorite"
    case removeFavorite = "remove_favorite"
    case viewFavorites = "view_favorites"
    
    // AR/VR 相关
    case immersiveSpaceEnter = "immersive_space_enter"
    case immersiveSpaceExit = "immersive_space_exit"
    case modelInteraction = "model_interaction"
    case immersiveSpaceMove = "immersive_space_move"
    case immersiveSpaceSelectFloor = "immersive_space_select_floor"
    case immersiveControlPanelClick = "immersive_control_panel_click"
    
    // 分享相关
    case shareContent = "share_content"
    case shareSuccess = "share_success"
    case shareFailed = "share_failed"
    
    // 错误事件
    case error = "error"
    case apiError = "api_error"
    case networkError = "network_error"

    /// 埋点类型，对应后端 trackType 字段
    var trackType: TrackType {
        switch self {
        case .appLaunch, .appBackground, .appForeground:
            return .appLifecycle
        case .userLogin, .userLogout, .userRegister:
            return .userAction
        case .pageView, .categoryView, .productView, .welcomeView,
             .homeViewEnter, .homeViewExit,
             .floorViewEnter, .floorViewExit,
             .floorDetailEnter, .floorDetailExit:
            return .pageView
        case .buttonClick, .floorSelect, .roomChange, .styleChange, .styleSelect:
            return .interaction
        case .search, .searchResult:
            return .search
        case .addFavorite, .removeFavorite, .viewFavorites:
            return .favorite
        case .immersiveSpaceEnter, .immersiveSpaceExit, .modelInteraction, .modelViewEnter,
             .modelViewExit, .immersiveSpaceMove, .immersiveSpaceSelectFloor, .immersiveControlPanelClick:
            return .immersive
        case .shareContent, .shareSuccess, .shareFailed:
            return .share
        case .error, .apiError, .networkError:
            return .error
        }
    }

    /// 便捷上报方法
    /// - Parameters:
    ///   - username: 当前用户名（未登录可传 "guest"）
    ///   - pagePath: 当前页面路由路径，便于还原场景
    ///   - trackData: 业务自定义数据，会被编码为 JSON 字符串
    ///   - extraInfo: 额外信息字段
    ///   - productName: 关联的产品名称（如有）
    ///   - completion: 请求回调，默认可忽略
    func record(
        username: String = "guest",
        pagePath: String? = nil,
        trackData: Encodable? = nil,
        extraInfo: String? = nil,
        productName: String? = nil,
        completion: ((Result<Bool, NetworkError>) -> Void)? = nil
    ) {
        // 将 trackData 编码为 JSON 字符串
        let trackDataString = trackData?.toJSONString()

        let request = TrackCreateRequest(
            username: username,
            eventName: self.rawValue,
            trackData: trackDataString,
            pagePath: pagePath,
            extraInfo: extraInfo,
            sessionTime: nil,
            pageSessionTime: nil,
            modelSessionTime: nil,
            avgWatchTime: nil,
            pageStayTime: nil,
            modelViewTime: nil,
            productName: productName
        )

        HttpClient.shared.recordTrack(request: request) { result in
            switch result {
            case .success:
                print("✅ 埋点上报成功: \(self.rawValue)")
            case .failure(let error):
                print("❌ 埋点上报失败: \(self.rawValue), error: \(error)")
            }
            completion?(result)
        }
    }
}

// 在 import Foundation 之后插入 TrackType 枚举以及工具扩展

enum TrackType: String, Codable {
    /// 应用生命周期相关
    case appLifecycle = "app_lifecycle"
    /// 用户行为相关
    case userAction = "user_action"
    /// 页面浏览相关
    case pageView = "page_view"
    /// 交互事件相关
    case interaction = "interaction"
    /// 搜索相关
    case search = "search"
    /// 收藏/喜欢相关
    case favorite = "favorite"
    /// AR/VR 相关
    case immersive = "immersive"
    /// 分享相关
    case share = "share"
    /// 错误相关
    case error = "error"
}

extension Encodable {
    /// 将可编码对象转为 JSON 字符串，失败时返回 nil
    fileprivate func toJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
