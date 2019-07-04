//
//  ArrayExtension.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public extension Array {
  public func get(_ index: Int) -> Element? {
    guard index >= 0 && index < count else { return nil }
    return self[index]
  }
}

public extension ArraySlice where Element: Any {
  public func toArray() -> Array<Element> {
    return Array(self)
  }
}
