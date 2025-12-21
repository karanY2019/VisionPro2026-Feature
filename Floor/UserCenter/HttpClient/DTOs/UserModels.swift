//
//  UserModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - User Request Models
struct UserQueryRequest: Codable {
    let id: Int?
    let userCode: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let dealerId: Int?
    let status: Int?
    let pageNum: Int
    let pageSize: Int
    
    init(id: Int? = nil, userCode: String? = nil, username: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, dealerId: Int? = nil, status: Int? = nil, pageNum: Int = 1, pageSize: Int = 10) {
        self.id = id
        self.userCode = userCode
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dealerId = dealerId
        self.status = status
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

struct UserCodeRequest: Codable {
    let userCode: String
}

struct EmailRequest: Codable {
    let email: String
}

struct UserLoginRequest: Codable {
    let username: String
}

struct UserLogoutRequest: Codable {
    let username: String
}

struct UserCreateRequest: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let email: String?
    let dealerId: Int
    
    init(username: String, firstName: String, lastName: String, email: String? = nil, dealerId: Int) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dealerId = dealerId
    }
}

struct UserUpdateRequest: Codable {
    let id: Int
    let username: String
    let firstName: String
    let lastName: String
    let email: String
    let dealerId: Int
}

struct UserStatusRequest: Codable {
    let id: Int
    let status: Int
}

// MARK: - User Response Models
struct UserResponse: Codable, CustomStringConvertible {
    let code: Int
    let message: String
    let data: UserData
    let timestamp: Int64

    var description: String {
        """
        UserResponse:
          code: \(code)
          message: \(message)
          timestamp: \(timestamp)
          data: \(data)
        """
    }

    struct UserData: Codable, CustomStringConvertible {
        let id: Int
        let userCode: String
        let username: String
        let firstName: String
        let lastName: String
        let email: String?
        let dealerId: Int
        let dealerName: String
        let status: Int
        let statusText: String
        let isOnline: Int
        let onlineText: String
        let lastLoginTime: String?
        let lastLogoutTime: String?
        let loginIp: String?
        let createTime: String
        let updateTime: String

        var description: String {
            """
            UserData:
              id: \(id)
              userCode: \(userCode)
              username: \(username)
              firstName: \(firstName)
              lastName: \(lastName)
              email: \(email ?? "")
              dealerId: \(dealerId)
              dealerName: \(dealerName)
              status: \(status)
              statusText: \(statusText)
              isOnline: \(isOnline)
              onlineText: \(onlineText)
              lastLoginTime: \(lastLoginTime ?? "")
              lastLogoutTime: \(lastLogoutTime ?? "")
              loginIp: \(loginIp ?? "")
              createTime: \(createTime)
              updateTime: \(updateTime)
            """
        }
    }
} 
