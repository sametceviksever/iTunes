//
//  UIViewExtension.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 4.03.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

extension UIView {
  @IBInspectable
  public var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable
  public var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  public var borderColor: UIColor? {
    get {
      let color = UIColor(cgColor: layer.borderColor!)
      return color
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  public var shadowColor: UIColor? {
    get {
      let color = UIColor(cgColor: layer.shadowColor!)
      return color
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  public var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.masksToBounds = false
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  public var shadowOpacity: CGFloat {
    get {
      return CGFloat(layer.shadowOpacity)
    }
    set {
      layer.masksToBounds = false
      layer.shadowOpacity = Float(newValue)
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.masksToBounds = false
      layer.shadowRadius = newValue
    }
  }
}
