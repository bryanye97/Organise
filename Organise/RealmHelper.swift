//
//  RealmHelper.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static func addNote(note: Note) {
        let realm = try! Realm()
        
        try! realm.write() {
            realm.add(note)
        }
    }
    
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        let realm = try! Realm()
        
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    static func retrieveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
    
}

