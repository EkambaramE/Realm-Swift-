//
//  RealmManager.swift
//  RealmHelper
//
//  Created by Gayathri on 21/04/16.
//  Copyright © 2016 Gayathri_b. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm
class RealmManager<T:Object> {
  
  //Write values to Realm DB
  //Update values to Realm DB
  //Delete values from Realm DB
  
   let defaultRealm = try! Realm()
  
  
   //MARK:Fetch values from Realm DB :arguments predicate and Model Class return type Array of Model Objects
  
  func fetchObjectsFromRealmDataBase(predicate:NSPredicate,model:Object.Type)->Results<Object> {
    
   return defaultRealm.objects(model).filter(predicate)
  }
  //MARK:Delete all the entries from Realm DB
  func deleteEntriesFromRealm (){
    //to delete all entries from DB
    try! defaultRealm.write {
      defaultRealm.deleteAll()
    }
    //delete single entry from DB
    
  }
  func singleEntryDelete (model:Object){
    try! defaultRealm.write({
      defaultRealm.delete(model)
    })
  }
  
  //MARK:Add objects to realm DataBase
  func insertIntoRealmDB(model:Object,update:Bool){
    if update {
      try! defaultRealm.write {
       defaultRealm.add(model, update: true)
      }
    }
    else{
    try! defaultRealm.write {
      defaultRealm.add(model)
    }
    }
  }
  func insertIntoRealmUsingJSON(model:Object.Type,jsonData:NSData){
    try! defaultRealm.write {
      let json = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions())
      defaultRealm.create(model.self, value: json, update: true)
    }
  }
  
}