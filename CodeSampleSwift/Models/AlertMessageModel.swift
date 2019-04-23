//
//  MessageModel.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

protocol AlertMessageProtocol {
    var title: String? { get }
    var message: String? { get }
}

struct AlertMessage: AlertMessageProtocol {
    var title: String?
    var message: String?
    
    init(title: String?, message: String?) {
        self.title = title
        self.message = message
    }
}
