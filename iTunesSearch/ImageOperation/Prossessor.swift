//
//  Prossessor.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 5.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit
private var tasks: [UIImageView: String] = [:]
public struct Proccessor<Base> {
  let base: Base
  var downloadTask: URLSessionDataTask?
  public init(_ base: Base) {
    self.base = base
  }
}

public protocol ProccessorProtocol { }

public extension ProccessorProtocol {
  var processor: Proccessor<Self> {
    get {return Proccessor(self)}
    set { }
  }
}

public extension Proccessor where Base: UIImageView {
  
  func setImage(with urlString: String?, placeHolder: UIImage? = nil) {
    
    var mutableSelf = self
    tasks[mutableSelf.base] = urlString
    guard let urlString = urlString else {
      mutableSelf.base.image = placeHolder
      return
    }
    
    if let image: UIImage = CacheManager.shared.get(for: urlString) {
      mutableSelf.base.image = image
      
    } else if let image = checkFiles(for: urlString) {
      mutableSelf.base.image = image
      CacheManager.shared.record(item: image, for: urlString)
    } else {
      mutableSelf.base.image = placeHolder
      
      guard let url = URL(string: urlString) else {
        return
      }
      
      mutableSelf.downloadTask = URLSession
        .shared
        .dataTask(with: url,
                  completionHandler: { (data, _, _) in
                    tasks[mutableSelf.base] = nil
                    if let data = data,
                      let image = UIImage(data: data) {
                      if let activeUrl = tasks[mutableSelf.base],
                        activeUrl == url.absoluteString {
                        DispatchQueue.main.async {
                          mutableSelf.base.image = UIImage(data: data)
                        }
                      }
                      CacheFileManager
                        .shared?
                        .store(data: data, for: urlString)
                      CacheManager.shared.record(item: image, for: urlString)
                    }
        })
      mutableSelf.downloadTask?.resume()
    }
  }
  
  private func checkFiles(for urlString: String) -> UIImage? {
    do {
      if let data = try CacheFileManager.shared?.value(for: urlString),
        let image = UIImage(data: data) {
        return image
      }
    } catch let error {
      print(error)
    }
    
    return nil
  }
}
