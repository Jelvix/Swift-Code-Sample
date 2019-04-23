//
//  Results.swift
//  CodeSampleSwift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let results: [Result]?

    enum DataCodingKeys: String, CodingKey {
        case data
    }
    enum ResultsCodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataCodingKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: ResultsCodingKeys.self, forKey: .data)
        results = try? resultsContainer.decode([Result].self, forKey: .results)
    }
}

struct Result: Decodable {
    let type: String
    let user: User
}
