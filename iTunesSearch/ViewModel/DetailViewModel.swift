//
//  DetailViewModel.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 4.03.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit
import AVKit

public class DetailViewModel {
  
  public var deleteItem: ((String) -> Void)?
  public var dismissHandler: VoidBlock?
  public let media: MediaViewModel
  private var isDeleted: Bool = false
  
  init(_ media: MediaViewModel, deleteHandler: @escaping ((String) -> ())) {
    self.media = media
    self.deleteItem = deleteHandler
  }
  
  public func callDeleteIfNeeded() {
    if isDeleted {
      deleteItem?(media.id)
    }
  }
  
  @objc private func itemDelete() {
    isDeleted = true
    dismissHandler?()
  }
  
  public func getAlertViewForSure() -> UIViewController {
    let localMessage = "If you click yes the %@ will delete.".local
    let message = String(format: localMessage, media.name)
    let alertView = UIAlertController(title: "Are You Sure For Delete ?".local, message: message, preferredStyle: .alert)
    
    alertView.addAction(UIAlertAction(title: "Yes".local, style: .cancel, handler: { [weak self] (_) in
      self?.itemDelete()
    }))
    
    alertView.addAction(UIAlertAction(title: "No".local, style: .default, handler: nil))
    
    return alertView
  }
  
  public func preparePreview() -> UIViewController? {
    guard let urlString = media.previewUrl,
    let url = URL(string: urlString) else {return nil}
    let player = AVPlayer(url: url)
    let vcPlayer = AVPlayerViewController()
    vcPlayer.player = player
    return vcPlayer
  }
}
