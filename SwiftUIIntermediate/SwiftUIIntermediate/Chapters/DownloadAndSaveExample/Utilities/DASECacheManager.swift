//
//  DASECacheManager.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 20/10/2024.
//

import UIKit

final class DASECacheManager {
    
    // MARK: - Properties
    
    static let shared = DASECacheManager()
    
    private var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200MB
        return cache
    }()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Methods
    
    func add(_ image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
