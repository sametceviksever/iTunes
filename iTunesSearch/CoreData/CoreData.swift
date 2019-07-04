//
//  CoreData.swift
//  iTunesSearch
//
//  Created by Samet Çeviksever on 3.07.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation
import CoreData

public enum EntityType: String{
  case visited = "Visited"
  case deleted = "Deleted"
}

public class CoreData {
  public static var shared:CoreData = CoreData()
  
  public var visitedMedias: [String] = []
  public var deletedMedias: [String] = []
  
  private init() {
    visitedMedias = getMedias(for: .visited)
    deletedMedias = getMedias(for: .deleted)
  }
  private func getMedias(for entityType: EntityType) -> [String] {
    var medias: [String] = []
    for item in getData(from: entityType.rawValue){
      if let id = item.value(forKey: "mediaId") as? String{
        medias.append(id)
      }
    }
    return medias
  }
  
  private func getData(from entityName: String) -> [NSManagedObject]{
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      if let items = result as? [NSManagedObject]{
        return items
      } else {
        return [NSManagedObject]()
      }
    } catch {
      return [NSManagedObject]()
    }
  }
  
  @discardableResult
  public func saveMedia(with id:String, to entityType: EntityType) -> Bool{
    let entity = NSEntityDescription.entity(forEntityName: entityType.rawValue, in: context)
    let newObject = NSManagedObject(entity: entity!, insertInto: context)
    newObject.setValue(id, forKey: "mediaId")
    
    do{
      try context.save()
      if entityType == .visited {
        visitedMedias.append(id)
      } else {
        deletedMedias.append(id)
      }
      return true
    } catch {
      print("Failed saving")
      return false
    }
    
  }
  
  fileprivate var context: NSManagedObjectContext {get {
    if #available(iOS 10.0, *) {
      return persistentContainer.viewContext
    } else {
      return managedObjectContext
    }
    }
  }
  
  @available(iOS 10.0, *)
  fileprivate lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Media")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? { }
    })
    return container
  }()
  
  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    do {
      return try NSPersistentStoreCoordinator.coordinator(name: "Media")
    } catch {
      print("CoreData: Unresolved error \(error)")
    }
    return nil
    
  }()
  
  private lazy var managedObjectContext: NSManagedObjectContext = {
    let coordinator = self.persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
  }()
}
