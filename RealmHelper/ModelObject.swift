//
//  ModelObject.swift
//  RealmHelper
//
//  Created by Gayathri on 21/04/16.
//  Copyright © 2016 Gayathri_b. All rights reserved.
//

import Foundation
import RealmSwift

class ModelObject:Object {
   let id = RealmOptional<Int>()
   dynamic var brandName: String = "Gap"
   dynamic var value:String = "Aiyo"
   override static func primaryKey() -> String? {
    return "id"
   }
}