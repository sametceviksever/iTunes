//
//  MediaTypeVC.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class MediaTypeVC: UIViewController, Reusable {
  deinit {
    print("MediaTypeVC Deinit")
    tableView.removeObserver(self, forKeyPath: "contentSize")
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  public var viewModel: MediaTypeViewModel!
  public var okButtonPressed: ((MediaType) -> Void)?
  
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.hideEmptyCells()
  }
  
  public override func observeValue(forKeyPath keyPath: String?,
                                    of object: Any?,
                                    change: [NSKeyValueChangeKey : Any]?,
                                    context: UnsafeMutableRawPointer?) {
    var size = tableView.contentSize
    size.height = viewModel.estimatedHeight(with: tableView.contentSize)
    size.width = viewModel.estimatedWidth()
    preferredContentSize = size
  }
  
  @IBAction func buttonPressed() {
    okButtonPressed?(viewModel.selectedMediaType)
    dismiss(animated: true, completion: nil)
  }
}

extension MediaTypeVC: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.rowCount
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let type = viewModel.mediaType(for: indexPath)
    cell.textLabel?.text = type.name
    cell.accessoryType = viewModel.selectedMediaType == type ? .checkmark : .none
    cell.selectionStyle = .none
    return cell
  }
}

extension MediaTypeVC: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.typeSelected(at: indexPath)
    tableView.reloadData()
  }
}
