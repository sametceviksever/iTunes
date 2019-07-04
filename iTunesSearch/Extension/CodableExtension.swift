//
//  CodableExtension.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum SerilazableError: Error {
  case convertError
  
  public var localizedDescription: String {
    switch self {
    case .convertError:
      return "Item can't convert to json"
    }
  }
}

public extension Encodable {
  
  func rawData() throws -> Data {
    let encoder = JSONEncoder()
    return try encoder.encode(self)
  }
  
  func json() throws -> [String: Any] {
    let data = try rawData()
    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
      return json
    }
    throw SerilazableError.convertError
  }
}
