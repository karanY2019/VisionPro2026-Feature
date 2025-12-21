//
//  HttpClient+Admin.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Admin Management APIs
extension HttpClient {
    
    func adminLogin(username: String, password: String, completion: @escaping (Result<AdminResponse, NetworkError>) -> Void) {
        let request = AdminLoginRequest(username: username, password: password)
        self.request(endpoint: "/admin/login", requestBody: request, responseType: AdminResponse.self) { result in
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
    
    func adminLogout(username: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let request = AdminLogoutRequest(username: username)
        self.request(endpoint: "/admin/logout", requestBody: request, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 