//
//  ImageCacheService.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 26/05/2024.
//

import Foundation
import UIKit

protocol ImageCacheService {
    func store(key: String, image: CGImage)
    func get(key: String) -> CGImage?
}

class LocalImageCacheService: ImageCacheService {
    private lazy var cache: NSCache<AnyObject, CGImage> = {
        let cache = NSCache<AnyObject, CGImage>()
        cache.countLimit = 100
        return cache
    }()
    
    func store(key: String, image: CGImage) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func get(key: String) -> CGImage? {
        return cache.object(forKey: key as AnyObject)
    }
}
