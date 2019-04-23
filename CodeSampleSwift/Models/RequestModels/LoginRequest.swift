//
//  UserServiceRequests.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    var facebookID: String?
    var facebookToken: String?

    init(facebookID: String?, facebookToken: String?) {
        self.facebookID = facebookID
        self.facebookToken = facebookToken
    }

    enum CodingKeys: String, CodingKey {
        case facebookID = "id"
        case facebookToken = "token"
    }
}
