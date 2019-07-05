//
//  UIImage+Cache.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 2.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public protocol Costable: class {
  var cost: Int { get }
}

extension UIImage: Costable {
  public var cost: Int {
    let pixel = Int(size.width * size.height * scale * scale)
    guard let cgImage = cgImage else {
      return pixel * 4
    }
    return pixel * cgImage.bitsPerPixel / 8
  }
}

extension UIImageView: ProccessorProtocol{ }
