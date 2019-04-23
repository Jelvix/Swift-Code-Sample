//
//  UIImageView+Cache.swift
//  CodeSampleSwift
//
//  Copyright © 2018 Jelvix. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    private static var taskKey = 0
    
    private var currentTask: URLSessionTask? {
        get { return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func jx_setImage(url: URL) {
        currentTask?.cancel()
        currentTask = nil
        self.image = nil

        if let cachedImage = JXImageCache.image(url: url) {
            self.image = cachedImage
            return
        }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            self?.currentTask = nil
            if let data = data, let image = UIImage(data: data) {
                JXImageCache.save(image: image, forUrl: url)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        currentTask = downloadTask
        downloadTask.resume()
    }
}
