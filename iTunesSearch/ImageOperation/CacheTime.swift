//
//  CacheTime.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 4.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum CacheTime {
  private static var hourInterval: TimeInterval = 60 * 60
  
  case hour
  case days(Double)
  case date(Date)
  case never
  case expired
  
  fileprivate var time: TimeInterval {
    switch self {
    case .hour: return CacheTime.hourInterval
    case .days(let day): return CacheTime.hourInterval * 24 * day
    case .date(let date): return date.timeIntervalSinceNow
    case .never: return .infinity
    case .expired: return -(.infinity)
    }
  }
  
  public var isExpired: Bool {
    return time <= 0
  }
  
  func estimatedExpirationSince(_ date: Date) -> Date {
    switch self {
    case .never: return .distantFuture
    case .hour: return date.addingTimeInterval(time)
    case .days: return date.addingTimeInterval(time)
    case .date(let ref): return ref
    case .expired: return .distantPast
    }
  }
  
  var estimatedExpirationSinceNow: Date {
    return estimatedExpirationSince(Date())
  }
}
