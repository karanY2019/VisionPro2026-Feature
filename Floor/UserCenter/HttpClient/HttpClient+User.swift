//
//  HttpClient+User.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - User Management APIs
extension HttpClient {
    
    func getUserList(query: UserQueryRequest, completion: @escaping (Result<PageResponse<UserResponse>, NetworkError>) -> Void) {
        request(endpoint: "/users/list", requestBody: query, responseType: PageResponse<UserResponse>.self) { result in
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
    
    func getUserDetail(query: UserQueryRequest, completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/users/detail", requestBody: query, responseType: UserResponse.self) { result in
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
    
    func getUserDetailByCode(userCode: String, completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        let request = UserQueryRequest(userCode: userCode)
        self.request(endpoint: "/users/detail-by-code", requestBody: request, responseType: UserResponse.self) { result in
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
    
    func getCodeByEmail(email: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let request = UserQueryRequest(email: email)
        self.request(endpoint: "/users/get-code-by-email", requestBody: request, responseType: String.self) { result in
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
    
    func userLogin(username: String, completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        let request = UserLoginRequest(username: username)
        self.request(endpoint: "/users/login", requestBody: request, responseType: UserResponse.self) { result in
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
    
    func userLogout(username: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let request = UserLogoutRequest(username: username)
        self.request(endpoint: "/users/logout", requestBody: request, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createUser(request: UserCreateRequest, completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/users/create", requestBody: request, responseType: UserResponse.self) { result in
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
    
    func updateUser(request: UserUpdateRequest, completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/users/update", requestBody: request, responseType: UserResponse.self) { result in
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
    
    func updateUserStatus(request: UserStatusRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/users/update-status", requestBody: request, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteUser(query: UserQueryRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/users/delete", requestBody: query, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 
