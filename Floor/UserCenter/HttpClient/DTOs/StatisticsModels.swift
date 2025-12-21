//
//  StatisticsModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Statistics Request Models
struct StatisticsRequest: Codable {
    let startTime: String?
    let endTime: String?
    let dealerId: Int?
    
    init(startTime: String? = nil, endTime: String? = nil, dealerId: Int? = nil) {
        self.startTime = startTime
        self.endTime = endTime
        self.dealerId = dealerId
    }
}

// MARK: - Statistics Response Models
struct ProductStatistics: Codable {
    let productName: String
    let count: Int
}

struct StatisticsResponse: Codable {
    let avgSessionTime: Double
    let totalSessionTime: Int
    let totalCustomers: Int
    let avgImmersiveSessionTime: Double
    let avgModelSessionTime: Double
    let activeUsers: Int
    let mostViewedProducts: [ProductStatistics]
    let mostFavoriteProducts: [ProductStatistics]
    let avgWatchTime: Double
} 