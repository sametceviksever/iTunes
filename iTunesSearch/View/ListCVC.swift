//
//  ListCVC.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class ListCVC: UICollectionViewCell, Reusable {
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblGenre: UILabel!
  @IBOutlet weak var lblRelease: UILabel!
  @IBOutlet weak var img: DownloadableImageView!
  @IBOutlet weak var container: UIView!
  
  public func configure(with model: MediaViewModel) {
    lblName.text = model.name
    lblGenre.text = model.genre
    lblRelease.text = model.releaseDate
    img.getImage(with: model.litleImageUrl)
    container.backgroundColor = model.isVisited ? UIColor.init(red: 0.90, green: 0.90, blue: 0.95, alpha: 1) : .white
  }
}
