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
    var trackType: String {
        switch self {
        case .appLaunch, .appBackground, .appForeground:
            return "app_lifecycle"
        case .userLogin, .userLogout, .userRegister:
            return "user_action"
        case .pageView, .categoryView, .productView, .welcomeView,
             .homeViewEnter, .homeViewExit,
             .floorViewEnter, .floorViewExit,
             .floorDetailEnter, .floorDetailExit:
            return "page_view"
        case .buttonClick, .floorSelect, .roomChange, .styleChange, .styleSelect:
            return "interaction"
        case .search, .searchResult:
            return "search"
        case .addFavorite, .removeFavorite, .viewFavorites:
            return "favorite"
        case .immersiveSpaceEnter, .immersiveSpaceExit, .modelInteraction, .modelViewEnter,
             .modelViewExit, .immersiveSpaceMove, .immersiveSpaceSelectFloor, .immersiveControlPanelClick:
            return "immersive"
        case .shareContent, .shareSuccess, .shareFailed:
            return "share"
        case .error, .apiError, .networkError:
            return "error"
        }
    }

    /// 便捷上报方法 - Respects build configuration settings
    /// - Parameters:
    ///   - username: 当前用户名（未登录可传 "idle"）
    ///   - pagePath: 当前页面路由路径，便于还原场景
    ///   - trackData: 业务自定义数据，会被编码为 JSON 字符串
    ///   - extraInfo: 额外信息字段
    ///   - productName: 关联的产品名称（如有）
    func record(
        username: String = "idle",
        pagePath: String? = nil,
        trackData: Encodable? = nil,
        extraInfo: String? = nil,
        productName: String? = nil
    ) {
        // Check development mode before making network calls
        #if DEBUG
        // In development mode, just log the event and skip network calls
        print("📊 Development mode - tracking event: \(self.rawValue)")
        print("   Username: \(username)")
        print("   Page Path: \(pagePath ?? "nil")")
        print("   Product: \(productName ?? "nil")")
        #else
        // In production mode, proceed with actual tracking
        // This would normally make the network call to the analytics API
        print("📊 Production mode - would send analytics event: \(self.rawValue)")
        // TODO: Implement actual network call here when deploying to production
        // self.sendToAnalyticsAPI(username: username, pagePath: pagePath, trackData: trackData, extraInfo: extraInfo, productName: productName)
        #endif
    }
}
