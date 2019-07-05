//
//  DetailVC.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 4.03.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, Reusable {
  
  @IBOutlet weak var imgPreview: UIImageView!
  @IBOutlet weak var img60: UIImageView!
  @IBOutlet weak var btnPlay: UIButton!
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblRelease: UILabel!
  @IBOutlet weak var lblGenre: UILabel!
  @IBOutlet weak var lblPrice: UILabel!
  @IBOutlet weak var lblDescription: UILabel!
  
  var playButtonClicked: (() -> Void)?
  var viewModel: DetailViewModel!
  
  deinit {
    print("DetailVC Deinit")
    viewModel.callDeleteIfNeeded()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.dismissHandler = {[weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
    configureView()
  }
  
  private func configureView() {
    let media = viewModel.media
    navigationItem.title = media.title
    lblName.text = media.name
    lblGenre.text = media.genre
    lblRelease.text = media.releaseDate
    if let price = media.price {
      let priceLocal = "Price".local
      lblPrice.text = String(format: priceLocal, price)
      lblPrice.isHidden = false
    } else {
      lblPrice.isHidden = true
    }
    
    if let desc = media.description {
      lblDescription.text = desc
      lblDescription.isHidden = false
    } else {
      lblDescription.isHidden = true
    }
    btnPlay.isHidden = media.previewUrl == nil
    
    img60.processor.setImage(with: media.litleImageUrl, placeHolder: UIImage(named: "placeholder"))
    imgPreview.processor.setImage(with: media.bigImageUrl)
    let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(askForSure))
    navigationItem.rightBarButtonItem = deleteButton
  }
  
  @objc private func askForSure() {
    let alert = viewModel.getAlertViewForSure()
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func play() {
    guard let preview = viewModel.preparePreview() else {
      return
    }
    present(preview, animated: true, completion: nil)
  }
}
