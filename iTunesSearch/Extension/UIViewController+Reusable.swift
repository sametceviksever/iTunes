//
//  UIViewController+Reusable.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public extension Reusable where Self: UIViewController {
  init() {
    let bundle = Bundle(for: Self.self)
    self.init(nibName: Self.reuseIdentifier, bundle: bundle)
  }
}
