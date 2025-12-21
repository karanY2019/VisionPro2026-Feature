//
//  AdminModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Admin Request Models
struct AdminLoginRequest: Codable {
    let username: String
    let password: String
}

struct AdminLogoutRequest: Codable {
    let username: String
}

// MARK: - Admin Response Models
struct AdminResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let realName: String
    let phone: String
    let status: Int
    let isOnline: Int
    let lastLoginTime: String?
    let loginIp: String?
    let createTime: String
    let updateTime: String
} 