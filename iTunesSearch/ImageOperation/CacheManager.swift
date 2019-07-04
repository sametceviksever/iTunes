//
//  CacheManager.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 2.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

enum CacheError: Error {
  case fileNotExist
  case cannotConvertData
}

public struct CacheManager {
  public static var shared: CacheManager = CacheManager()
  
  private let cache = NSCache<NSString, AnyObject>()
  private let fileManager: CacheFileManager? = CacheFileManager.shared
  
  public func record (image: UIImage,
                     for key: String,
                     until cacheTime: CacheTime) {
    
    cache.setObject(image, forKey: key as NSString, cost: image.cost)
    fileManager?.store(data: image.pngData(), for: key)
  }
  
  public func get(for key: String) -> UIImage? {
    if let image = cache.object(forKey: key.md5 as NSString) as? UIImage {
      return image
    }
    
    do {
      if let data = try fileManager?.value(for: key) {
        return UIImage(data: data)
      }
    } catch {
      return nil
    }
    
    return nil
  }
}
