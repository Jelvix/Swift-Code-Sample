//
//  User.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

enum MatchType: String, Codable {
    case pass = "pass"
    case like = "like"
}

struct User: Codable {
    var name: String
    var userID: String
    var bio: String
    var photos: [UserPhoto]?
    
    enum CodingKeys: String, CodingKey {
        case name, bio, photos
        case userID = "_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        userID  = try container.decode(String.self, forKey: .userID)
        bio = try container.decode(String.self, forKey: .bio)
        photos = try? container.decode([UserPhoto].self, forKey: .photos)
    }
}

struct UserPhoto: Codable {
    var photoID: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case url
    }
}
