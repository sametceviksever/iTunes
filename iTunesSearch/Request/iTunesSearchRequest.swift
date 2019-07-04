//
//  iTunesSearchRequest.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

struct iTunesSearchRequest: Request {

  var url: String {return "https://itunes.apple.com/search"}
  var methodType: MethodType {return .get}
  var headers: [String : String] {return [:]}
  var body: iTunesRequestObject?
  var handler: (((Result<iTunesModel, NetworkError>) -> Void))?
  
  init(searchText: String, mediaType: MediaType?) {
    self.body = iTunesRequestObject(term: searchText,
                                    media: mediaType?.requestName)
  }
}
