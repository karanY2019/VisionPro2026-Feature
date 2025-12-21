//
//  DealerModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Dealer Request Models
struct DealerQueryRequest: Codable {
    let id: Int?
    let code: String?
    let name: String?
    let email: String?
    let status: Int?
    let pageNum: Int
    let pageSize: Int
    
    init(id: Int? = nil, code: String? = nil, name: String? = nil, email: String? = nil, status: Int? = nil, pageNum: Int = 1, pageSize: Int = 10) {
        self.id = id
        self.code = code
        self.name = name
        self.email = email
        self.status = status
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

struct DealerCreateRequest: Codable {
    let name: String
    let code: String
    let email: String?
    let phone: String?
    let address: String?
    let description: String?
}

struct DealerUpdateRequest: Codable {
    let id: Int
    let name: String
    let code: String
    let email: String?
    let phone: String?
    let address: String?
    let description: String?
}

struct DealerStatusRequest: Codable {
    let id: Int
    let status: Int
}

struct DealerCodeRequest: Codable {
    let code: String
}

// MARK: - Dealer Response Models
struct DealerResponse: Codable {
    let id: Int
    let name: String
    let code: String
    let email: String?
    let phone: String?
    let address: String?
    let description: String?
    let status: Int
    let statusText: String
    let createTime: String
    let updateTime: String
} 