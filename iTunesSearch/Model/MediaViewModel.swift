//
//  MediaViewModel.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public struct MediaViewModel {
  public let id: String
  public let name: String
  public let bigImageUrl: String?
  public let litleImageUrl: String?
  public let description: String?
  public let price: String?
  public let genre: String?
  public let releaseDate: String?
  public let title: String?
  public let previewUrl: String?
  public var isVisited: Bool
  
  public init(with media: iTunesMedia) {
    bigImageUrl = media.artworkUrl100
    litleImageUrl = media.artworkUrl60
    genre = media.primaryGenreName
    title = media.mediaKind?.name
    previewUrl = media.previewUrl
    releaseDate = media.releaseDate?.format(from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "dd MMM yyyy")
    if media.wrapper == WrapperType.audioBook {
      id = "\(media.collectionId ?? 0)"
      description = media.collectionDescription
      name = media.collectionName ?? ""
      price = "\(media.collectionPrice ?? 0) \(media.currency?.symbol ?? "")"
    } else {
      id = "\(media.trackId ?? 0)"
      description = media.longDescription
      name = media.trackName ?? ""
      price = "\(media.trackPrice ?? 0) \(media.currency?.symbol ?? "")"
    }
    isVisited = CoreData.shared.visitedMedias.contains(id)
  }
}
