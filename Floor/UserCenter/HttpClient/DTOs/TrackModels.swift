//
//  TrackModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Track Request Models
struct TrackQueryRequest: Codable {
    let id: Int?
    let userId: Int?
    let userCode: String?
    let requestIp: String?
    let requestPath: String?
    let requestMethod: String?
    let trackType: String?
    let eventName: String?
    let startTime: String?
    let endTime: String?
    let pageNum: Int
    let pageSize: Int
    
    init(id: Int? = nil, userId: Int? = nil, userCode: String? = nil, requestIp: String? = nil, requestPath: String? = nil, requestMethod: String? = nil, trackType: String? = nil, eventName: String? = nil, startTime: String? = nil, endTime: String? = nil, pageNum: Int = 1, pageSize: Int = 10) {
        self.id = id
        self.userId = userId
        self.userCode = userCode
        self.requestIp = requestIp
        self.requestPath = requestPath
        self.requestMethod = requestMethod
        self.trackType = trackType
        self.eventName = eventName
        self.startTime = startTime
        self.endTime = endTime
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

struct TrackCreateRequest: Codable {
    let username: String
    let eventName: String
    let trackData: String?
    let pagePath: String?
    let extraInfo: String?
    let sessionTime: Int?
    let pageSessionTime: Int?
    let modelSessionTime: Int?
    let avgWatchTime: Int?
    let pageStayTime: Int?
    let modelViewTime: Int?
    let productName: String?
}

struct SessionTrackRequest: Codable {
    let userCode: String
    let eventName: String
    let trackData: String?
    let pagePath: String?
    let extraInfo: String?
    let sessionTime: Int
    let pageSessionTime: Int?
    let modelSessionTime: Int?
    let avgWatchTime: Int?
    let pageStayTime: Int?
    let modelViewTime: Int?
    let productName: String?
}

struct TrackByUserRequest: Codable {
    let userCode: String
}

struct TrackByIpRequest: Codable {
    let requestIp: String
}

struct TrackByTypeRequest: Codable {
    let trackType: String
}

struct TrackByTimeRequest: Codable {
    let startTime: String
    let endTime: String
}

struct TrackByProductRequest: Codable {
    let productName: String
}

// MARK: - Track Response Models
struct TrackResponse: Codable {
    let id: Int
    let userId: Int
    let userCode: String
    let requestIp: String
    let requestPath: String
    let requestMethod: String
    let requestParams: String?
    let responseStatus: Int
    let userAgent: String?
    let trackType: String
    let eventName: String
    let trackData: String?
    let executionTime: Int
    let sessionTime: Int
    let pageSessionTime: Int
    let modelSessionTime: Int
    let avgWatchTime: Int
    let pageStayTime: Int
    let modelViewTime: Int
    let productName: String?
    let deleted: Int
    let createTime: String
}

struct SessionStatsResponse: Codable {
    let sessionDate: String
    let totalSessionTime: Int
    let sessionCount: Int
    let averageSessionTime: Int
} 
