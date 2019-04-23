//
//  StoryboardHelper.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardHelper {
    case main
    case auth
    
    var storyboard: UIStoryboard {
        switch self {
        case .auth:
            return UIStoryboard(name: "Authorization", bundle: nil)
        case .main:
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
}
