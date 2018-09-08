//
//  SessionManager.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit
import CoreData

class SessionManager: NSObject {
    static let sharedManager = SessionManager()

    @objc dynamic var accessToken: String = ""
    
    override init() {
        super.init()
        OperationQueue.main.addOperation() {
            self.fetchUser()
        }
    }
    
    private func fetchUser() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "token", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects, fetchedObjects.count > 0{
                    accessToken = fetchedObjects.first!.token ?? ""
                    return fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        return []
    }
    
    func saveAccessToken(_ token: String) {
        OperationQueue.main.addOperation() {
            self.accessToken = token
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let user = User(context: appDelegate.persistentContainer.viewContext)
                user.token = token
                appDelegate.saveContext()
            }
        }
    }
    
    func clear() {
        // Clear all data
        OperationQueue.main.addOperation() {
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let userToDelete = self.fetchUser()
                userToDelete.forEach { user in
                    context.delete(user)
                }
                appDelegate.saveContext()
            }
            self.accessToken = ""
        }
    }
    
}
