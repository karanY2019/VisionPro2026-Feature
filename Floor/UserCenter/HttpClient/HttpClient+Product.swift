//
//  HttpClient+Product.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

// MARK: - Product Management APIs
extension HttpClient {
    
    func getProductList(query: ProductQueryRequest, completion: @escaping (Result<PageResponse<ProductResponse>, NetworkError>) -> Void) {
        request(endpoint: "/products/list", requestBody: query, responseType: PageResponse<ProductResponse>.self) { result in
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
    
    func getProductDetail(query: ProductQueryRequest, completion: @escaping (Result<ProductResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/products/detail", requestBody: query, responseType: ProductResponse.self) { result in
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
    
    func getProductsByType(query: ProductQueryRequest, completion: @escaping (Result<[ProductResponse], NetworkError>) -> Void) {
        self.request(endpoint: "/products/by-type", requestBody: query, responseType: [ProductResponse].self) { result in
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
    
    func getEnabledProducts(completion: @escaping (Result<[ProductResponse], NetworkError>) -> Void) {
        let request = EmptyRequest()
        self.request(endpoint: "/products/enabled", requestBody: request, responseType: [ProductResponse].self) { result in
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
    
    func createProduct(request: ProductCreateRequest, completion: @escaping (Result<ProductResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/products/create", requestBody: request, responseType: ProductResponse.self) { result in
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
    
    func updateProduct(request: ProductUpdateRequest, completion: @escaping (Result<ProductResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/products/update", requestBody: request, responseType: ProductResponse.self) { result in
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
    
    func updateProductStatus(query: ProductQueryRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/products/update-status", requestBody: query, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteProduct(query: ProductQueryRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/products/delete", requestBody: query, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Product Type Management APIs
extension HttpClient {
    
    func getProductTypeList(query: ProductTypeQueryRequest, completion: @escaping (Result<PageResponse<ProductTypeResponse>, NetworkError>) -> Void) {
        request(endpoint: "/product-types/list", requestBody: query, responseType: PageResponse<ProductTypeResponse>.self) { result in
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
    
    func getProductTypeDetail(query: ProductTypeQueryRequest, completion: @escaping (Result<ProductTypeResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/product-types/detail", requestBody: query, responseType: ProductTypeResponse.self) { result in
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
    
    func getEnabledProductTypes(completion: @escaping (Result<[ProductTypeResponse], NetworkError>) -> Void) {
        let request = EmptyRequest()
        self.request(endpoint: "/product-types/enabled", requestBody: request, responseType: [ProductTypeResponse].self) { result in
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
    
    func createProductType(request: ProductTypeCreateRequest, completion: @escaping (Result<ProductTypeResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/product-types/create", requestBody: request, responseType: ProductTypeResponse.self) { result in
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
    
    func updateProductType(request: ProductTypeUpdateRequest, completion: @escaping (Result<ProductTypeResponse, NetworkError>) -> Void) {
        self.request(endpoint: "/product-types/update", requestBody: request, responseType: ProductTypeResponse.self) { result in
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
    
    func updateProductTypeStatus(query: ProductTypeQueryRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/product-types/update-status", requestBody: query, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteProductType(query: ProductTypeQueryRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.request(endpoint: "/product-types/delete", requestBody: query, responseType: EmptyResponse.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 