//
//  CurrencyType.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum CurrencyType: String, Codable {
  case usd = "USD"
  
  public var symbol: String {
    switch self {
    case .usd:
      return "$"
    }
  }
}
