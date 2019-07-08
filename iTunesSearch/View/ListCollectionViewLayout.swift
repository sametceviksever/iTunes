//
//  ListCollectionViewLayout.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 8.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

private enum Layout {
  static var itemCountIntLine: Int {
    let deviceType = UIDevice.current.userInterfaceIdiom
    let orientation = UIDevice.current.orientation
    
    switch (deviceType, orientation) {
    case (.pad, _):
      itemCount = 2
    case (_, .portrait), (_, .portraitUpsideDown):
      itemCount = 1
    case (_, .landscapeLeft), (_, .landscapeRight):
      itemCount = 2
    default:
      break
    }
    
    return itemCount
  }
  
  private static var itemCount: Int = 0
}

public class ListCollectionViewLayout: UICollectionViewFlowLayout {
  private let cellHeight: CGFloat = 80
  
  public override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else {
      return
    }
    
    let maxItemCount = Layout.itemCountIntLine
    let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
    let cellWidth = (availableWidth / CGFloat(maxItemCount)).rounded(.down)
    
    self.itemSize = CGSize(width: cellWidth, height: cellHeight)
  }
  
  public override var sectionHeadersPinToVisibleBounds: Bool {
    get {return true}
    set { }
  }
}
