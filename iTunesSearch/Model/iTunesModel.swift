//
//  iTunesModel.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public struct iTunesModel: Codable {
  let resultCount: Int
  var results: [iTunesMedia]
}

public struct iTunesMedia: Codable {
  let previewUrl: String?
  let artworkUrl60: String?
  let artworkUrl30: String?
  let artworkUrl100: String?
  let releaseDate: String?
  let trackName: String?
  let mediaKind: MediaType?
  let currency: CurrencyType?
  let trackPrice: Float?
  let primaryGenreName: String?
  let longDescription: String?
  let trackId: Int?
  let wrapper: WrapperType?
  let collectionName: String?
  let collectionPrice: Float?
  let collectionDescription: String?
  let collectionId: Int?
  
  private enum CodingKeys: String, CodingKey {
    case previewUrl
    case artworkUrl30
    case artworkUrl60
    case artworkUrl100
    case releaseDate
    case trackName
    case mediaKind = "kind"
    case currency
    case trackPrice
    case primaryGenreName
    case longDescription
    case trackId
    case wrapper = "wrapperType"
    case collectionName
    case collectionPrice
    case collectionDescription = "description"
    case collectionId
  }
}
