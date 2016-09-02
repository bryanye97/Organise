//
//  Note.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation

class Note {
    var title: String
    var content: String
    var modificationTime: NSDate
    
    init(title: String, content: String, modificationTime: NSDate) {
        self.title = title
        self.content = title
        self.modificationTime = modificationTime
    }
}
