//
//  iTunesRequest.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

struct ITunesRequestModel: Encodable {
  let term: String
  let limit: Int
  let media: String?
  
  init(term: String,
       limit: Int = 100,
       media: String?) {
    self.term = term.replacingOccurrences(of: " ", with: "+")
    self.limit = limit
    self.media = media
  }
}
