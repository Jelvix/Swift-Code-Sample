//
//  AlertHelper.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import Foundation
import UIKit

struct AlertHelper {
    static func showAlertController(title:String?, message:String?, controller: UIViewController?, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: handler))
            controller?.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showMessage<T: AlertMessageProtocol>(message: T, controller: UIViewController?) {
        showAlertController(title: message.title, message: message.message, controller: controller, handler: nil)
    }
    
    static func showMessage<T: AlertMessageProtocol>(message: T, controller: UIViewController?, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        showAlertController(title: message.title, message: message.message, controller: controller, handler: handler)
    }
    
    static func showMessage<T: AlertMessageProtocol>(message: T, fromController controller: UIViewController?, okButtonTitle okTitle: String, cancelButtonTitle cancelTitle: String, okHandler: ((UIAlertAction) -> Swift.Void)? = nil, cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: message.title, message: message.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: okHandler))
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
            controller?.present(alert, animated: true, completion: nil)
        }
    }
}
