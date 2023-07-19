//
//  NetworkManager.swift
//  AsyncAwaitMVVM
//
//  Created by PHN Tech 2 on 19/07/23.
//

import Foundation
enum FetchingError: Error{
    case invalidUrl
    case invalidResponse
    case invalidData
    case error(Error)
}

enum Event{
    case startLoading
    case stopLoading
    case reloadData
    case error(FetchingError)
}

final class NetworkManager{
    static let shared = NetworkManager()
    private init(){}
    
    func apiCall<T: Decodable>(model: T.Type, whichMethod type: EndpointItems) async throws -> (Result<T,FetchingError>){
        guard let url = type.url else{
            return .failure(.invalidUrl)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        
        if let body = type.parameter{
            request.httpBody = body
        }
        
        request.allHTTPHeaderFields = type.header
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else{
            return .failure(.invalidResponse)
        }
        print(response.statusCode)
        let result = try JSONDecoder().decode(model, from: data)
        return .success(result)
    }
}
