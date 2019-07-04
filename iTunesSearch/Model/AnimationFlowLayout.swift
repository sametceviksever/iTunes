//
//  AnimationFlowLayout.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 5.03.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

class AnimationFlowLayout: UICollectionViewFlowLayout {
  override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let attribute = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {return nil}
    
    attribute.transform = attribute.transform.translatedBy(x: 0, y: 80)
    attribute.alpha = 0.0
    return attribute
  }
}
