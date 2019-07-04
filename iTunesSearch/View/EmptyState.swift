//
//  EmptyState.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 5.03.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class EmptyState: BaseView {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblMessage: UILabel!
  
  public func configure(with title: String, message: String) {
    lblTitle.text = title
    lblMessage.text = message
  }
}
