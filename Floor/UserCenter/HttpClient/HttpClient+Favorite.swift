//
//  HttpClient+Favorite.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Favorites Management APIs
extension HttpClient {
    
    func addFavorite(request: FavoriteCreateRequest, completion: @escaping (Result<FavoriteResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/create", requestBody: request, responseType: FavoriteResponse.self) { result in
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
    
    func updateFavorite(request: FavoriteUpdateRequest, completion: @escaping (Result<FavoriteResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/update", requestBody: request, responseType: FavoriteResponse.self) { result in
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
    
    func deleteFavorite(request: FavoriteDeleteRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/delete", requestBody: request, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFavoriteDetail(query: FavoriteQueryRequest, completion: @escaping (Result<FavoriteResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/detail", requestBody: query, responseType: FavoriteResponse.self) { result in
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
    
    func getUserFavorites(query: FavoriteQueryRequest, completion: @escaping (Result<[FavoriteResponse.FavoriteData], NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/list-by-user", requestBody: query, responseType: [FavoriteResponse.FavoriteData].self) { result in
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
    
    func getFavoritesPage(query: FavoriteQueryRequest, completion: @escaping (Result<PageResponse<FavoriteResponse>, NetworkError>) -> Void) {
        request(endpoint: "/user-favorites/page", requestBody: query, responseType: PageResponse<FavoriteResponse>.self) { result in
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
    
    func searchFavoritesByProduct(query: FavoriteQueryRequest, completion: @escaping (Result<[FavoriteResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/search-by-product", requestBody: query, responseType: [FavoriteResponse].self) { result in
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
    
    func getFavoritesBySource(query: FavoriteQueryRequest, completion: @escaping (Result<[FavoriteResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/list-by-source", requestBody: query, responseType: [FavoriteResponse].self) { result in
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
    
    func getFavoritesByTime(query: FavoriteQueryRequest, completion: @escaping (Result<[FavoriteResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/list-by-time", requestBody: query, responseType: [FavoriteResponse].self) { result in
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
    
    func countUserFavorites(query: FavoriteQueryRequest, completion: @escaping (Result<Int64, NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/count-by-user", requestBody: query, responseType: Int64.self) { result in
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
    
    func checkFavorited(query: FavoriteQueryRequest, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        self.request(endpoint: "/user-favorites/check-favorited", requestBody: query, responseType: Bool.self) { result in
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