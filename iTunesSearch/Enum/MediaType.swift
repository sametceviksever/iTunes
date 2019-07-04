//
//  MediaType.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum WrapperType: String, Codable {
  case track = "track"
  case audioBook = "audiobook"
}

public enum MediaType: String, Codable {
  case all = "all"
  case movie = "movie"
  case podcast = "podcast"
  case music = "music"
  case song = "song"
  case featureMovie = "feature-movie"
  case tvEpisode = "tv-episode"
  case musicVideo = "music-video"
  
//  public init(_ kindName: String) {
//    guard let item = MediaType(rawValue: kindName) else {
//      if kindName.contains("movie") {
//        self = .movie
//      } else {
//        self = .all
//      }
//      return
//    }
//    
//    self = item
//  }
  
  public var name: String {
    return rawValue.local
  }
  
  public var requestName: String? {
    switch self {
    case .all:
      return nil
    default:
      return rawValue.lowercased()
    }
  }
}
