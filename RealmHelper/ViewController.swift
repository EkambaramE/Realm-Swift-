//
//  ViewController.swift
//  RealmHelper
//
//  Created by Gayathri on 21/04/16.
//  Copyright © 2016 Gayathri_b. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UITableViewController {
  let brandArray = ["Gap","Banana Republic","Bossa","Hugo Bossa","Taylor","Rebecca Taylor"]
  let UpdatedbrandArray = ["Gpeaaa","Banana Rpublic","Bossaa","Hgo Bossaa","Taylora","Rebecca Taylora"]
  var realmManager:RealmManager<Object>?
  override func viewDidLoad() {
    super.viewDidLoad()
    realmManager = RealmManager()
    realmManager!.deleteEntriesFromRealm()
    loadDataIntoDB()
    print(Realm.Configuration.defaultConfiguration.path!)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func loadDataIntoDB(){
    for i in 0...5 {
      
        let clothBrands = ModelObject()
        clothBrands.brandName = brandArray[i]
        clothBrands.id.value = 100+i
        realmManager!.insertIntoRealmDB(clothBrands, update: false)
     
    }
  }
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseCell")
    cell?.textLabel?.text = (((realmManager!.fetchObjectsFromRealmDataBase(NSPredicate(format: "brandName CONTAINS[c]'a'"), model: ModelObject.self) as Results<Object>)[indexPath.row]) as! ModelObject).brandName
    return cell!
  }
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  let object = ((realmManager!.fetchObjectsFromRealmDataBase(NSPredicate(format: "brandName CONTAINS[c]'a'"), model: ModelObject.self) as Results<Object>)[indexPath.row] as! ModelObject)

  //realmManager.insertIntoRealmDB(object.self, update: true)
    try! realmManager!.defaultRealm.write {
       object.brandName = UpdatedbrandArray[indexPath.row]
      realmManager!.defaultRealm.add(object, update: true)
    }
  tableView.beginUpdates()
  tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
  tableView.endUpdates()
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return realmManager!.fetchObjectsFromRealmDataBase(NSPredicate(format: "brandName CONTAINS[c]'a'"), model: ModelObject.self).count
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

