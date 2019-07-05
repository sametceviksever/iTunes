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
  
  public func record<T: Costable> (item: T,
                     for key: String) {
    
    cache.setObject(item, forKey: key.md5 as NSString, cost: item.cost)
  }
  
  public func get<T>(for key: String) -> T? {
    if let item = cache.object(forKey: key.md5 as NSString) as? T {
      return item
    }
    return nil
  }
}
