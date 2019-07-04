//
//  FileOperation.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 2.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import UIKit

public class FileOperations {
  public static var shared: FileOperations = FileOperations()
  
  public lazy var recordsInProgress: [String: Operation] = [:]
  public lazy var recordQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "Record queue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
}
