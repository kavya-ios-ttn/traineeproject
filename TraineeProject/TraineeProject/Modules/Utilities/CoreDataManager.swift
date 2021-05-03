//
//  CoreDataManager.swift
//  TraineeProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import CoreData


//made entity and set attributes in the xcdatamodel as email, firstname, lastname, password and dob
struct  CoreDataManager {
    
    //made a singleton class called CoreDataManager
    //with a shared variable which is static and initializer is made as private
    static let shared = CoreDataManager()
    
    
    //PersistentContainer is a container than holds all the UserData and entities(where we put data into a database)
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TraineeProject")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of data store failed \(error)")
            }
            
        }
         return container
    }()
   
    //created two functions called createUserDetails and fectchUserDetails to store data
    func createUserDetails(firstName: String, lastName: String, emailID: String, password: String, dob: Date) -> NewUserData? {
        
        let context = persistentContainer.viewContext
        let userdata = NSEntityDescription.insertNewObject(forEntityName: "NewUserData", into: context) as! NewUserData
        userdata.firstName = firstName
        userdata.lastName = lastName
        userdata.emailID = emailID
        userdata.password = password
        userdata.dob = dob
        
        do {
            try context.save()
            return userdata
        } catch let createError {
            print("failed to create the user data: \(createError)")
        }
        return nil
    }
    
    func fetchUserDetails() -> [NewUserData]? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NewUserData>(entityName: "NewUserData")
        
        do {
            let details = try context.fetch(fetchRequest)
            return details
        } catch let fetchError {
            print("Failed to fetch data of the new user: \(fetchError)")
        }
        return nil
    }
    
    
    func fetchUserDetails(withEmail email: String) -> NewUserData? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NewUserData>(entityName: "NewUserData")
        //fetchLimit = 1 means that at a time only one request can be fetched
        fetchRequest.fetchLimit = 1
        //NSPredicate is a kind of a condition like if email ID matches the format, then it fetches the email
        fetchRequest.predicate = NSPredicate(format: "emailID == %@", email)
        
        do {
            let details = try context.fetch(fetchRequest)
            return details.first
        } catch let fetchError {
            print("Failed to fetch User details: \(fetchError)")
        }
        return nil
    }
    
    func deleteUserDetails(userdetails: NewUserData){
        
        let context = persistentContainer.viewContext
        context.delete(userdetails)
        
        do {
            try context.save()
        } catch let saveError {
            print ("Failed to delete data of the user: \(saveError)")
        }
        
    }
    
    
}
