//
//  DownloadableImageView.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class DownloadableImageView: UIImageView {

  private var dataTask: URLSessionDataTask?
  
  public func getImage(with url: URL?, placeHolder: UIImage? = nil) {
    self.image = UIImage(named: "placeholder")
    guard let url = url else {
      return
    }
    if let image: UIImage = CacheManager.shared.get(for: url.absoluteString) {
      self.image = image
    }
    
    dataTask?.cancel()
    dataTask = URLSession.shared.dataTask(with: url,
                                          completionHandler: { [weak self] (data, response, error) in
                                            guard let `self` = self else {
                                              return
                                            }
                                            
                                            if let data = data {
                                              let image = UIImage(data: data)
                                              DispatchQueue.main.async(execute: {
                                                self.image = image
                                                if let image = image {
                                                  CacheManager.shared.record(image: image, for: url.absoluteString, until: .never)
                                                }
                                              })
                                            }})
    dataTask?.resume()
  }
  
  public func getImage(with url: String?, placeHolder: UIImage? = nil) {
    guard let str = url else {
      return
    }
    getImage(with: URL(string: str), placeHolder: placeHolder)
  }
}
