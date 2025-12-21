//
//  HttpClient+Track.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - User Tracking APIs
extension HttpClient {
    
    func recordTrack(request: TrackCreateRequest, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/record", requestBody: request, responseType: Bool.self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func recordSessionTrack(request: SessionTrackRequest, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/record-session", requestBody: request, responseType: Bool.self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTracksByUser(request: TrackByUserRequest, completion: @escaping (Result<[TrackResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/list-by-user", requestBody: request, responseType: [TrackResponse].self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTracksByIP(request: TrackByIpRequest, completion: @escaping (Result<[TrackResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/list-by-ip", requestBody: request, responseType: [TrackResponse].self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTracksPage(query: TrackQueryRequest, completion: @escaping (Result<PageResponse<TrackResponse>, NetworkError>) -> Void) {
        request(endpoint: "/user-track/page", requestBody: query, responseType: PageResponse<TrackResponse>.self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTracksByType(request: TrackByTypeRequest, completion: @escaping (Result<[TrackResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/list-by-type", requestBody: request, responseType: [TrackResponse].self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTracksByTime(request: TrackByTimeRequest, completion: @escaping (Result<[TrackResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/list-by-time", requestBody: request, responseType: [TrackResponse].self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTracksByProduct(request: TrackByProductRequest, completion: @escaping (Result<[TrackResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/list-by-product", requestBody: request, responseType: [TrackResponse].self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func countUserTracks(request: TrackByUserRequest, completion: @escaping (Result<Int64, NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/count-by-user", requestBody: request, responseType: Int64.self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func countIPTracks(request: TrackByIpRequest, completion: @escaping (Result<Int64, NetworkError>) -> Void) {
        self.request(endpoint: "/user-track/count-by-ip", requestBody: request, responseType: Int64.self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getClientIP(completion: @escaping (Result<String, NetworkError>) -> Void) {
        let request = EmptyRequest()
        self.request(endpoint: "/user-track/get-client-ip", requestBody: request, responseType: String.self) { result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    func getSessionStats(query: TrackQueryRequest, completion: @escaping (Result<[[String: Any]], NetworkError>) -> Void) {
//        // Note: This endpoint returns a complex Map structure, may need custom handling
//        self.request(endpoint: "/user-track/session-stats", requestBody: query, responseType: [[String: Any]].self) { result in
//            switch result {
//            case .success(let response):
//                if let data = response.data {
//                    completion(.success(data))
//                } else {
//                    completion(.failure(.noData))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
} 
