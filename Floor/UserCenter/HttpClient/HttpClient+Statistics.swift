//
//  HttpClient+Statistics.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Statistics APIs
extension HttpClient {
    
    func getStatistics(request: StatisticsRequest, completion: @escaping (Result<StatisticsResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/statistics/get", requestBody: request, responseType: StatisticsResponse.self) { result in
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
    
    func getAllStatistics(completion: @escaping (Result<StatisticsResponse, NetworkError>) -> Void) {
        let request = EmptyRequest()
        self.request(endpoint: "/statistics/get-all", requestBody: request, responseType: StatisticsResponse.self) { result in
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
} 