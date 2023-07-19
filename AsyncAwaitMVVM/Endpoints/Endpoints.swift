//
//  Endpoints.swift
//  AsyncAwaitMVVM
//
//  Created by PHN Tech 2 on 19/07/23.
//

import Foundation

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol EndPointTypes{
    var baseUrl: String{get}
    var path: String{get}
    var url: URL?{get}
    var httpMethod: HTTPMethod{get}
    var parameter: Data?{get}
    var header: [String : String]?{get}
}

enum EndpointItems{
    case getAlbum
    case getUsers
}

extension EndpointItems: EndPointTypes{
    var baseUrl: String {
        switch self{
            
        case .getAlbum:
            return "https://jsonplaceholder.typicode.com/"
        case .getUsers:
            return "https://jsonplaceholder.typicode.com/"
        }
        
    }
    
    var path: String {
        switch self{
        case .getAlbum:
            return "albums"
        case .getUsers:
            return "posts"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getAlbum:
            return .get
        case .getUsers:
            return .get
        }
    }
    
    var parameter: Data? {
        switch self{
            
        case .getAlbum:
            return Data()
        case .getUsers:
            return Data()
        }
    }
    
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
