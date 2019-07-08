//
//  AppDelegate.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    createApplication()
    return true
  }
  
  private func createApplication() {
    window = UIWindow()
    let viewModel = ListViewModel(fetcher: Network.shared)
    let vc = ListVC.init()
    vc.viewModel = viewModel
    let nvc = UINavigationController(rootViewController: vc)
    window?.rootViewController = nvc
    window?.makeKeyAndVisible()
  }
  
}

