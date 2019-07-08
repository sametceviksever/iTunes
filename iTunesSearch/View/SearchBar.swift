//
//  SearchBar.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 5.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public protocol SearchBarDelegate: class {
  func searchBar(_ searchBar: SearchBar, textDidChange searchText: String)
  func searchBarDidBeginEditing(_ searchBar: SearchBar)
  func searchBarDidEndEditing(_ searchBar: SearchBar)
}

public class SearchBar: BaseView {
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var cancelButton: UIButton!
  public var placeHolder: String? {
    didSet {
      textField.placeholder = placeHolder
    }
  }
  
  fileprivate weak var delegate: SearchBarDelegate?
  
  public func configure(with delegate: SearchBarDelegate) {
    
    textField.backgroundColor = UIColor.white
    textField.autocorrectionType = .no
    textField.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
    textField.delegate = self
    self.delegate = delegate
  }
  
  @objc private func valueChanged(sender: UITextField) {
    delegate?.searchBar(self, textDidChange: sender.text ?? "")
  }
  
  @IBAction private func closeButtonTapped() {
    textField.text = ""
    delegate?.searchBar(self, textDidChange: "")
    textField.resignFirstResponder()
  }
  
  public func forceEndEditing() {
    textField.resignFirstResponder()
  }
}

extension SearchBar: UITextFieldDelegate {
  public func textFieldDidEndEditing(_ textField: UITextField) {
    delegate?.searchBarDidEndEditing(self)
    cancelButton.isHidden = true
    updateConstraints()
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    delegate?.searchBarDidBeginEditing(self)
    cancelButton.isHidden = false
    updateConstraints()
  }
}
