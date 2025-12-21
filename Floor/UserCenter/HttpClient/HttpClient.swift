//
//  HttpClient.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - HttpClient Main Class
class HttpClient {
    static let shared = HttpClient()
    
    private let session: URLSession
    private let baseURL: String
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: config)
        // http://159.75.138.120:9010/
        self.baseURL = "http://159.75.138.120:9010/api" // TODO: Replace with actual domain
        
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
        
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }
    
    // MARK: - Generic Request Method
    internal func request<T: Codable, R: Codable>(
        endpoint: String,
        requestBody: T,
        responseType: R.Type,
        completion: @escaping (Result<ApiResponse<R>, NetworkError>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add internationalization header
        if let languageCode = Locale.current.languageCode {
            request.setValue(languageCode, forHTTPHeaderField: "Accept-Language")
        }
        
        do {
            request.httpBody = try encoder.encode(requestBody)
            
            // Print request body for debugging
            if let requestBodyString = String(data: request.httpBody!, encoding: .utf8) {
                print("🌐 Request Body: \(requestBodyString)")
            }
        } catch {
            completion(.failure(.encodingError(error)))
            return
        }
        
        session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("🌐 Network Error: \(error.localizedDescription)")
                    print("🌐 Error Domain: \(error._domain)")
                    print("🌐 Error Code: \(error._code)")
                    completion(.failure(.networkError(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                // Print raw response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("🌐 Raw Response: \(responseString)")
                }
                
                do {
                    // Try to decode as ApiResponse first
                    let apiResponse = try self?.decoder.decode(ApiResponse<R>.self, from: data)
                    if let apiResponse = apiResponse {
                        print("🌐 Decoded Response - Code: \(apiResponse.code), Message: \(apiResponse.message)")
                        if apiResponse.code == 200 {
                            completion(.success(apiResponse))
                        } else {
                            completion(.failure(.apiError(apiResponse.code, apiResponse.message)))
                        }
                    } else {
                        completion(.failure(.decodingError(NSError(domain: "HttpClient", code: -1))))
                    }
                } catch {
                    print("🌐 Decoding Error: \(error)")
                    print("🌐 Error Details: \(error.localizedDescription)")
                    
                    // Try to decode as direct response type (in case server doesn't wrap in ApiResponse)
                    do {
                        let directResponse = try self?.decoder.decode(R.self, from: data)
                        if let directResponse = directResponse {
                            print("🌐 Direct Response Decoded Successfully")
                            // Create a mock ApiResponse with success
                            let mockApiResponse = ApiResponse<R>(code: 0, message: "Success", data: directResponse, timestamp: Int64(Date().timeIntervalSince1970))
                            completion(.success(mockApiResponse))
                        } else {
                            completion(.failure(.decodingError(error)))
                        }
                    } catch {
                        print("🌐 Direct Response Decoding Also Failed: \(error)")
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
        }.resume()
    }
}
