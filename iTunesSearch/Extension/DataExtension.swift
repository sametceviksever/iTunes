//
//  DataExtension.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public extension Data {
  func decode<T>() throws -> T where T: Decodable {
    let decoder = JSONDecoder()
    let result = try decoder.decode(T.self, from: self)
    return result
  }
}
