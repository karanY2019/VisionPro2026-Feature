//
//  NetworkModels.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Generic Response Models
struct ApiResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
    let timestamp: Int64
}

// MARK: - Page Response Models
struct PageResponse<T: Codable>: Codable {
    let list: [T]
    let total: Int64
    let pageNum: Int
    let pageSize: Int
    let pages: Int
    let hasNextPage: Bool
    let hasPreviousPage: Bool
}

// MARK: - Common Request Models
struct EmptyRequest: Codable {
    // Empty request body
}

struct EmptyResponse: Codable {
    // Empty response body
}

struct IDRequest: Codable {
    let id: Int
}

struct StringResponse: Codable {
    let value: String
}

struct BooleanResponse: Codable {
    let value: Bool
}

struct LongResponse: Codable {
    let value: Int64
}

// MARK: - Network Error Types
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
    case encodingError(Error)
    case decodingError(Error)
    case apiError(Int, String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data received"
        case .encodingError(let error):
            return "Encoding error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .apiError(let code, let message):
            return "API error \(code): \(message)"
        }
    }
} 