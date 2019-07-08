//
//  ListVC.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public typealias VoidBlock = (() -> Void)

public class ListVC: UIViewController, Reusable {
  
  var viewModel: ListViewModel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: SearchBar!
  
  deinit {
    print("ListVC Deinit")
  }
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.reloadDataHandler = {[weak self] in
      self?.collectionView.reloadData()
    }
    
    viewModel.reloadIndexesHandler = {[weak self] indexes in
      self?.remove(indexes: indexes)
    }
    
    collectionView.registerCell(type: ListCVC.self)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(rotated),
                                           name: UIDevice.orientationDidChangeNotification,
                                           object: nil)
    navigationItem.setRightBarButton(rightButton, animated: false)
    collectionView.dataSource = self
    collectionView.delegate = self
    navigationItem.title = "iTunes Search".local
    searchBar.configure(with: self, placeHolder: "Your Search Text".local)
  }
  
  lazy var rightButton: UIBarButtonItem = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
    button.setTitle("Media Type".local, for: .normal)
    button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    button.setTitleColor(UIColor.blue, for: .normal)
    return UIBarButtonItem(customView: button)
  }()
  
  @objc fileprivate func buttonClicked(_ sender: UIButton) {
    if let vc = viewModel.popover(sender, for: self) {
      present(vc, animated: true, completion: nil)
    }
  }
  
  private func popover(controller: UIViewController) {
    present(controller, animated: true, completion: nil)
  }
  
  @objc private func rotated() {
    collectionView.reloadData()
  }
  
  private func remove(indexes: [IndexPath]) {
    collectionView.performBatchUpdates({
      self.collectionView?.deleteItems(at: indexes)
    }) { (_) in
      UIView.setAnimationsEnabled(true)
    }
  }
}

extension ListVC: UISearchBarDelegate {
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.didChanged(searchText: searchText)
  }
  
  public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.text = viewModel.searchText
    return true
  }
}

extension ListVC: SearchBarDelegate {
  public func searchBar(_ searchBar: SearchBar, textDidChange searchText: String) {
    viewModel.didChanged(searchText: searchText)
  }

  public func searchBarDidBeginEditing(_ searchBar: SearchBar) { }

  public func searchBarDidEndEditing(_ searchBar: SearchBar) { }
}

extension ListVC: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if viewModel.rowCount == 0 {
      collectionView.setEmptyMessage()
    } else {
      collectionView.restore()
    }
    
    return viewModel.rowCount
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ListCVC = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    let media = viewModel.media(for: indexPath)
    cell.configure(with: media)
    
    return cell
  }
}

extension ListVC: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let collectionViewWidth = collectionView.bounds.width
    if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation.isLandscape {
      let size = CGSize(width: collectionViewWidth / 2, height: 80)
      return size
    }
    
    return CGSize(width: collectionViewWidth, height: 80)
  }
}

extension ListVC: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    searchBar.forceEndEditing()
    viewModel.setVisitid(at: indexPath)
    collectionView.reloadItems(at: [indexPath])
    let vc = viewModel.prepareDetail(for: indexPath, for: navigationController)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    searchBar.forceEndEditing()
  }
}


extension ListVC: UIPopoverPresentationControllerDelegate {
  public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
}
