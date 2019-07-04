//
//  File.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 2.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public struct File {
  let url: URL
  
  let estimatedTime: CacheTime
  let isDirectory: Bool
  let fileSize: Int
  
  public var isExpired: Bool {return estimatedTime.isExpired}
  
  public init(with fileUrl: URL, resourceKeys: Set<URLResourceKey>) throws {
    let meta = try fileUrl.resourceValues(forKeys: resourceKeys)
    self.url = fileUrl
    if let date = meta.contentModificationDate {
      self.estimatedTime = .date(date)
    } else {
      self.estimatedTime = .expired
    }
    self.isDirectory = meta.isDirectory ?? false
    self.fileSize = meta.fileSize ?? 0
  }
}
