//
//  Note.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Note: Object {
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var modificationTime: NSDate = NSDate()
}
