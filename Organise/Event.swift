//
//  Event.swift
//  Organise
//
//  Created by Bryan Ye on 7/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import RealmSwift
import EventKit
import Realm

class Event: Object {
    dynamic var title: String
    dynamic var content: String
    dynamic var date: NSDate
    
    init(title: String, content: String, date: NSDate) {
        self.title = title
        self.content = content
        self.date = date
        super.init()
    }
    
    required init() {
        self.title = ""
        self.content = ""
        self.date = NSDate()
        super.init()
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        self.title = ""
        self.content = ""
        self.date = NSDate()
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        self.title = ""
        self.content = ""
        self.date = NSDate()
        super.init(realm: realm, schema: schema)
    }
    
    
}
