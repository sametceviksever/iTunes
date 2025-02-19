//
//  MediaTypeViewModel.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class MediaTypeViewModel {
  deinit {
    print("MediaTypeViewModel deinit")
  }
  private(set) public var selectedMediaType:MediaType
  private var typeList: [MediaType] = [.movie, .music, .podcast, .all]
  private let buttonHeight: CGFloat = 45
  private let witdh: CGFloat = 150
  
  public var rowCount: Int {
    return typeList.count
  }
  
  public init(_ mediaType: MediaType) {
    self.selectedMediaType = mediaType
  }
  
  public func mediaType(for indexPath: IndexPath) -> MediaType {
    return typeList[indexPath.row]
  }
  
  public func typeSelected(at indexPath: IndexPath) {
    selectedMediaType = typeList[indexPath.row]
  }
  
  public func estimatedWidth() -> CGFloat {
    return witdh
  }
  
  public func estimatedHeight(with contentSize: CGSize) -> CGFloat {
    return contentSize.height + 45
  }
}
