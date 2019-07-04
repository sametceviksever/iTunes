//
//  StringExtension.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation
import CommonCrypto

public extension String {
  var local: String {
    let localized = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    if localized == "" {
      return self
    }
    
    return localized
  }
  
  func format(from: String, to: String) -> String? {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = from
    if let date = formatter.date(from: self){
      formatter.dateFormat = to
      return formatter.string(from: date)
    }
    return nil
  }
  
  var md5: String {
    guard let data = self.data(using: .utf8) else {
      return self
    }
    var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    #if swift(>=5.0)
    _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
      return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
    }
    #else
    _ = data.withUnsafeBytes { bytes in
      return CC_MD5(bytes, CC_LONG(data.count), &digest)
    }
    #endif
    
    return digest.map { String(format: "%02x", $0) }.joined()
  }
}
