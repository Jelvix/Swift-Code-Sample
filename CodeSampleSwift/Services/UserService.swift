//
//  UserService.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

class UserService: BaseService {
    static func loginUser(loginRequest: LoginRequest, success: @escaping Success, failure: @escaping Failure) {
        guard let request = try? API.logIn(request: loginRequest).urlRequest() else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data!) {
                UserService.token = loginResponse.token
                success()
            } else {
                failure(mapError(data))
            }
        }.resume()
    }
    
    static func matchUser(matchType: MatchType, userID: String, failure: @escaping Failure) {
        guard let request = try? API.matchUser(type: matchType, userId: userID).urlRequest() else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                failure(mapError(data))
            }
        }.resume()
    }
}
