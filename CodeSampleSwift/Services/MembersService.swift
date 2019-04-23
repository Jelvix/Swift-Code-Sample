//
//  MembersService.swift
//  CodeSampleSwift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

class MembersService: BaseService {
    static func recommendedUsers(success: @escaping ([User]) -> (), failure: @escaping Failure) {
        guard let request = try? API.getRecommendedUsers.urlRequest() else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let userResp = try? JSONDecoder().decode(Results.self, from: data!) {
                let users: [User] = userResp.results?.map { $0.user } ?? []
                success(users)
            } else {
                failure(mapError(data))
            }
        }.resume()
    }
}
