//
//  ErrorModel.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

struct ErrorModel: Codable, AlertMessageProtocol {
    var title: String?
    var message: String?
    
    init(title:String?, message:String?) {
        self.title = title
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case message = "error"
    }
}
