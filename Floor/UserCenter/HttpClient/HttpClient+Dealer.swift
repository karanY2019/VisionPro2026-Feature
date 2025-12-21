//
//  HttpClient+Dealer.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Dealer Management APIs
extension HttpClient {
    
    func getDealerList(query: DealerQueryRequest, completion: @escaping (Result<PageResponse<DealerResponse>, NetworkError>) -> Void) {
        request(endpoint: "/dealers/list", requestBody: query, responseType: PageResponse<DealerResponse>.self) { result in
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
    
    func getDealerDetail(query: DealerQueryRequest, completion: @escaping (Result<DealerResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/dealers/detail", requestBody: query, responseType: DealerResponse.self) { result in
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
    
    func getDealerDetailByCode(code: String, completion: @escaping (Result<DealerResponse, NetworkError>) -> Void) {
        let request = DealerQueryRequest(code: code)
        self.request(endpoint: "/dealers/detail-by-code", requestBody: request, responseType: DealerResponse.self) { result in
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
    
    func createDealer(request: DealerCreateRequest, completion: @escaping (Result<DealerResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/dealers/create", requestBody: request, responseType: DealerResponse.self) { result in
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
    
    func updateDealer(request: DealerUpdateRequest, completion: @escaping (Result<DealerResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/dealers/update", requestBody: request, responseType: DealerResponse.self) { result in
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
    
    func updateDealerStatus(request: DealerStatusRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/dealers/update-status", requestBody: request, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteDealer(query: DealerQueryRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/dealers/delete", requestBody: query, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 