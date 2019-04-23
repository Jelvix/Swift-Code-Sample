//
//  BaseServices.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation

typealias Success = () -> ()
typealias Failure = (ErrorModel) -> ()

class BaseService {
    static var token: String?
    
    static func mapError(_ errorData: Data?) -> ErrorModel {
        if let data = errorData {
            if let error = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                return ErrorModel(title: "Error!", message: error.message)
            }
        }
        return ErrorModel(title: "Error!", message: "Server error!")
    }
}
