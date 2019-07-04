//
//  TableViewExtension.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

extension UITableView {
  
  public func hideEmptyCells() {
    tableFooterView = UIView(frame: .zero)
  }
  
  //Identifier class Name ile Aynı verilmesi gerekmektedir.
  func registerCell<T: UITableViewCell>(type: T.Type) where T: Reusable {
    self.register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    
  }
  
  func dequeueReusableCell<T: UITableViewCell> (forIndexPath indexPath: IndexPath) -> T where T: Reusable {
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
  }
  
}

extension UITableView {
  
  func addTableHeaderView(headerView: UIView) {
    headerView.translatesAutoresizingMaskIntoConstraints = false
    self.tableHeaderView = headerView
    headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
  }
  
  func updateHeaderViewLayout() {
    guard let headerView = self.tableHeaderView else { return }
    headerView.layoutIfNeeded()
    let header = self.tableHeaderView
    self.tableHeaderView = header
  }
}
