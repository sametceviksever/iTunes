//
//  ListViewModel.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class ListViewModel {
  
  private var selectedType: MediaType = .all
  private var medias: [MediaViewModel] = []
  private var workItem: DispatchWorkItem?
  private(set) public var searchText: String
  private var fetcher: Network
  
  public var reloadDataHandler: VoidBlock?
  public var reloadIndexesHandler: (([IndexPath]) -> Void)?
  
  public var rowCount: Int {
    return medias.count
  }
  
  public init(fetcher: Network) {
    self.fetcher = fetcher
    searchText = ""
  }
  
  public func media(for indexPath: IndexPath) -> MediaViewModel {
    return medias[indexPath.row]
  }
  
  public func didChanged(searchText: String) {
    self.searchText = searchText
    workItem?.cancel()
    workItem = DispatchWorkItem(block: {[weak self] in
      guard let `self` = self
        else { return }
      self.call()
    })
    workItem?.execute(after: 0.25)
  }
  
  public func delete(with mediaId: String) -> IndexPath? {
    if let index = medias.firstIndex(where: {$0.id == mediaId}) {
      CoreData.shared.saveMedia(with: mediaId, to: .deleted)
      medias.remove(at: index)
      return IndexPath(item: index, section: 0)
    }
    return nil
  }
  
  public func setVisitid(at indexPath: IndexPath) {
    CoreData.shared.saveMedia(with: medias[indexPath.row].id, to: .visited)
    medias[indexPath.row].isVisited = true
  }
  
  public func prepareDetail(for indexPath: IndexPath,
                            for navigator: UINavigationController?) -> UIViewController {
    let media = medias[indexPath.row]
    let viewModel = DetailViewModel(media, deleteHandler: { [weak self] (id) in
      if let indexPath = self?.delete(with: id) {
        self?.reloadIndexesHandler?([indexPath])
      }
    })
    let controller = DetailVC.init()
    controller.viewModel = viewModel
    
    return controller
  }
  
  public func popover(_ sender: UIButton,
                      for delegate: UIPopoverPresentationControllerDelegate) -> UIViewController? {
    let viewModel = MediaTypeViewModel(selectedType)
    let controller = MediaTypeVC.init()
    controller.viewModel = viewModel
    controller.modalPresentationStyle = .popover
    
    guard let popover = controller.presentationController as? UIPopoverPresentationController else {
      return nil
    }
    
    popover.sourceView = sender
    popover.sourceRect = sender.bounds
    popover.permittedArrowDirections = [.up]
    popover.delegate = delegate
    
    controller.okButtonPressed = {[weak self] type in
      self?.selectedType = type
      self?.call()
    }
    
    return controller
  }
  
  private func call() {
    if searchText == "" {
      medias = []
      reloadDataHandler?()
      return
    }
    var request = iTunesSearchRequest(searchText: searchText, mediaType: selectedType)
    request.handler = {[weak self] result in
      switch result {
      case .success(let response):
        self?.medias = response.results.map({MediaViewModel(with: $0)})
          .filter({!CoreData.shared.deletedMedias.contains($0.id)})
        self?.reloadDataHandler?()
      case .failure(let error):
        print(error)
      }
    }
    fetcher.call(with: request)
  }
}
