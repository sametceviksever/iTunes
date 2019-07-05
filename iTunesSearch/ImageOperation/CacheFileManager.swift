//
//  FileManager.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 4.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

private let constFilesDirectory: String = "com.samet.ceviksever"

public struct FileManagerConfig {
  
  public static var `default` = FileManagerConfig(name: "Default")
  
  public let expiration: CacheTime
  public let name: String
  public let fileManager: FileManager
  
  public init(name: String,
              expiration: CacheTime = .days(7),
              fileManager: FileManager = .default) {
    self.name = name
    self.expiration = expiration
    self.fileManager = fileManager
  }
}

public class CacheFileManager {
  
  public static var shared: CacheFileManager? = try? CacheFileManager(config: .default)
  
  public static func customize(with config: FileManagerConfig) {
    shared = try? CacheFileManager(config: config)
  }
  
  private let config: FileManagerConfig
  private let directoryUrl: URL
  
  public init(config: FileManagerConfig) throws {
    self.config = config
    let url = try config.fileManager.url(for: .cachesDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: true)
    let cacheName = String(format: "%@.%@", constFilesDirectory, config.name)
    directoryUrl = url.appendingPathComponent(cacheName, isDirectory: true)
    try createDirectoryIfNeeded()
  }
  
  private func createDirectoryIfNeeded() throws {
    let path = directoryUrl.path
    guard !config.fileManager.fileExists(atPath: path) else {return}
    
    try config.fileManager.createDirectory(atPath: path,
                                           withIntermediateDirectories: true,
                                           attributes: nil)
  }
  
  public func store (data: Data?,
                     for key: String,
                     until time: CacheTime? = nil) {
    
    let expiration = time ?? config.expiration
    guard !expiration.isExpired else {return}
    
    let fileUrl = directoryUrl.appendingPathComponent(key.md5)
    let now = Date()
    let attributes: [FileAttributeKey : Any] = [
      .creationDate: now.fileAttributeDate,
      .modificationDate: expiration.estimatedExpirationSinceNow.fileAttributeDate
    ]
    
    config.fileManager.createFile(atPath: fileUrl.path,
                                  contents: data,
                                  attributes: attributes)
  }
  
  public func value (for key: String) throws -> Data? {
    let fileManager = config.fileManager
    let fileURL = directoryUrl.appendingPathComponent(key.md5)
    let filePath = fileURL.path
    guard fileManager.fileExists(atPath: filePath) else {
      throw CacheError.fileNotExist
    }
    
    let resourceKeys: Set<URLResourceKey> = [.contentModificationDateKey, .creationDateKey]
    let file: File
    do {
      file = try File(with: fileURL, resourceKeys: resourceKeys)
    } catch {
      throw CacheError.fileNotExist
    }
    
    if file.isExpired {
      return nil
    }
    
    let data: Data
    do {
      data = try Data(contentsOf: fileURL)
      return data
    } catch {
      throw CacheError.cannotConvertData
    }
  }
}

fileprivate extension Date {
  var fileAttributeDate: Date {
    return Date(timeIntervalSince1970: ceil(timeIntervalSince1970))
  }
}
