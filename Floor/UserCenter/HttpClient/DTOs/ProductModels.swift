//
//  ProductModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Product Request Models
struct ProductQueryRequest: Codable {
    let id: Int?
    let name: String?
    let productTypeId: Int?
    let minPrice: Double?
    let maxPrice: Double?
    let unit: String?
    let status: Int?
    let pageNum: Int
    let pageSize: Int
    
    init(id: Int? = nil, name: String? = nil, productTypeId: Int? = nil, minPrice: Double? = nil, maxPrice: Double? = nil, unit: String? = nil, status: Int? = nil, pageNum: Int = 1, pageSize: Int = 10) {
        self.id = id
        self.name = name
        self.productTypeId = productTypeId
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.unit = unit
        self.status = status
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

struct ProductCreateRequest: Codable {
    let name: String
    let productTypeId: Int
    let price: Double
    let unit: String
    let imageUrl: String?
    let description: String?
}

struct ProductUpdateRequest: Codable {
    let id: Int
    let name: String
    let productTypeId: Int
    let price: Double
    let unit: String
    let imageUrl: String?
    let description: String?
}

struct ProductTypeRequest: Codable {
    let productTypeId: Int
}

// MARK: - Product Response Models
struct ProductResponse: Codable {
    let id: Int
    let name: String
    let productTypeId: Int
    let productTypeName: String
    let price: Double
    let unit: String
    let imageUrl: String?
    let description: String?
    let status: Int
    let statusText: String
    let createTime: String
    let updateTime: String
}

// MARK: - Product Type Request Models
struct ProductTypeQueryRequest: Codable {
    let id: Int?
    let name: String?
    let status: Int?
    let pageNum: Int
    let pageSize: Int
    
    init(id: Int? = nil, name: String? = nil, status: Int? = nil, pageNum: Int = 1, pageSize: Int = 10) {
        self.id = id
        self.name = name
        self.status = status
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

struct ProductTypeCreateRequest: Codable {
    let name: String
    let description: String?
}

struct ProductTypeUpdateRequest: Codable {
    let id: Int
    let name: String
    let description: String?
}

// MARK: - Product Type Response Models
struct ProductTypeResponse: Codable {
    let id: Int
    let name: String
    let description: String?
    let status: Int
    let statusText: String
    let createTime: String
    let updateTime: String
} 