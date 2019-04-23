//
//  CodeSampleSwift
//
//  Copyright © 2018 Jelvix. All rights reserved.
//

import Foundation
import UIKit

class JXImageCache {
    private static func cachePath(url: URL) -> URL? {
        guard let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return nil
        }
        return URL(fileURLWithPath: cacheDir + url.lastPathComponent)
    }
    
    static func image(url: URL) -> UIImage? {
        guard let cachePath = cachePath(url: url) else { return nil }
        return UIImage(contentsOfFile: cachePath.path)
    }
    
    static func save(image: UIImage, forUrl url: URL) {
        guard let cachePath = cachePath(url: url) else { return  }
        try? UIImageJPEGRepresentation(image, 1.0)?.write(to: cachePath)
    }
}
