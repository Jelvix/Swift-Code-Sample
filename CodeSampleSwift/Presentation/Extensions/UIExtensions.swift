//
//  UIExtensions.swift
//  CodeSampleSwift
//
//  Copyright © 2018 Jelvix. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var cellId: String {
        return String(describing: self)
    }
}

extension UIViewController {
    static var storyboardId: String {
        return String(describing: self)
    }
}
