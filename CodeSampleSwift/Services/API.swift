//
//  API.swift
//  CodeSampleSwift
//
//  Copyright © 2018 Jelvix. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

enum API {
    case logIn(request: LoginRequest)
    case matchUser(type: MatchType, userId: String)
    case getRecommendedUsers
    
    private var baseURL: String {
        return "https://api.gotinder.com/"
    }
    
    var method: HttpMethod {
        switch self {
        case .logIn, .matchUser:
            return .post
        case .getRecommendedUsers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .logIn:
            return "v2/auth/login/facebook"
        case let .matchUser(type, userId):
            return "\(type)/\(userId)"
        case .getRecommendedUsers:
            return "v2/recs/core"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL) else { throw JXError.invalidURL }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case let .logIn(request):
            guard let encodedData = try? JSONEncoder().encode(request) else { throw JXError.encodeFailed }
            urlRequest.httpBody = encodedData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        default:
            break
        }
        if let token = UserService.token {
            urlRequest.setValue(token, forHTTPHeaderField: "x-auth-token")
        }
        return urlRequest
    }
}
