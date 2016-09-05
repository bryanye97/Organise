//
//  NoteContentViewController.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import RealmSwift

class NoteContentViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveNote" {
            let destinationViewController = segue.destinationViewController as! ToDoListViewController
            if let note = note {
                let updatedNote = Note()
                updatedNote.title = noteTitleTextField.text ?? ""
                updatedNote.content = noteContentTextView.text ?? ""
                RealmHelper.updateNote(note, newNote: updatedNote)
            } else {
                let newNote = Note()
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                newNote.modificationTime = NSDate()
                
                RealmHelper.addNote(newNote)
            }
            
            destinationViewController.notesDataSource = RealmHelper.retrieveNotes()
            
        }
    }
}

