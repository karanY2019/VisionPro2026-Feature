//
//  FavoriteModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Favorite Request Models
struct FavoriteQueryRequest: Codable {
    let id: Int?
    let userId: Int?
    let username: String?
    let productName: String?
    let sourcePage: String?
    let startTime: String?
    let endTime: String?
    let pageNum: Int
    let pageSize: Int
    
    init(id: Int? = nil, userId: Int? = nil, username: String? = nil, productName: String? = nil, sourcePage: String? = nil, startTime: String? = nil, endTime: String? = nil, pageNum: Int = 1, pageSize: Int = 10) {
        self.id = id
        self.userId = userId
        self.username = username
        self.productName = productName
        self.sourcePage = sourcePage
        self.startTime = startTime
        self.endTime = endTime
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

struct FavoriteCreateRequest: Codable {
    let username: String
    let productInfo: String
    let sourcePage: String?
    let remark: String?
    
    init(username: String, productInfo: String, sourcePage: String? = nil, remark: String? = nil) {
        self.username = username
        self.productInfo = productInfo
        self.sourcePage = sourcePage
        self.remark = remark
    }
}

struct FavoriteUpdateRequest: Codable {
    let id: Int
    let productInfo: String?
    let sourcePage: String?
    let remark: String?
    
    init(id: Int, productInfo: String? = nil, sourcePage: String? = nil, remark: String? = nil) {
        self.id = id
        self.productInfo = productInfo
        self.sourcePage = sourcePage
        self.remark = remark
    }
}

struct FavoriteDeleteRequest: Codable {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
}

//struct FavoriteQueryRequest: Codable {
//    let pageNum: Int
//    let pageSize: Int
//    let userCode: String?
//    
//    init(pageNum: Int = 1, pageSize: Int = 10, userCode: String? = nil) {
//        self.pageNum = pageNum
//        self.pageSize = pageSize
//        self.userCode = userCode
//    }
//}

struct CheckFavoriteRequest: Codable {
    let userCode: String
    let productName: String
    
    init(userCode: String, productName: String) {
        self.userCode = userCode
        self.productName = productName
    }
}

struct ProductNameRequest: Codable {
    let productName: String
    
    init(productName: String) {
        self.productName = productName
    }
}

// MARK: - Favorite Response Models
struct FavoriteResponse: Codable, CustomStringConvertible {
    let code: Int
    let message: String
    let data: FavoriteData
    let timestamp: Int64

    var description: String {
        """
        FavoriteResponse:
          code: \(code)
          message: \(message)
          timestamp: \(timestamp)
          data: \(data)
        """
    }

    struct FavoriteData: Codable, CustomStringConvertible {
        let id: Int
        let userId: Int
        let username: String
        let productInfo: String
        let productName: String
        let productImage: String?
        let sourcePage: String?
        let remark: String?
        let deleted: Int
        let createTime: String
        let updateTime: String
        
        // 计算属性：从productInfo中解析出PGeneralItemInfo
        var generalInfo: PGeneralItemInfo? {
            return PGeneralItemInfo.fromJsonString(productInfo)
        }
        
        // 默认值静态方法
        static func defaultValue() -> FavoriteData {
            return FavoriteData(
                id: 0,
                userId: 0,
                username: "",
                productInfo: "{}",
                productName: "",
                productImage: nil,
                sourcePage: nil,
                remark: nil,
                deleted: 0,
                createTime: "",
                updateTime: ""
            )
        }

        var description: String {
            """
            FavoriteData:
              id: \(id)
              userId: \(userId)
              username: \(username)
              productInfo: \(productInfo)
              productName: \(productName)
              productImage: \(productImage ?? "")
              sourcePage: \(sourcePage ?? "")
              remark: \(remark ?? "")
              deleted: \(deleted)
              createTime: \(createTime)
              updateTime: \(updateTime)
            """
        }
    }
} 
