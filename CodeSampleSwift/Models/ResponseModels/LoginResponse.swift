//
//  LoginResponse.swift
//  CodeSampleSwift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//
import Foundation

struct LoginResponse: Decodable {
    var token: String

    enum DataCodingKeys: String, CodingKey {
        case data
    }

    enum TokenCodingKeys: String, CodingKey {
        case token = "api_token"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataCodingKeys.self)
        let tokenContainer = try container.nestedContainer(keyedBy: TokenCodingKeys.self, forKey: .data)
        token = try tokenContainer.decode(String.self, forKey: .token)
    }
}
