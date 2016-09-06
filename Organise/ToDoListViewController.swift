//
//  ToDoListViewController.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var notesDataSource: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesDataSource = RealmHelper.retrieveNotes()
        
        tableView.dataSource = self
        tableView.delegate = self

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "displayNote" {
                
                let indexPath = tableView.indexPathForSelectedRow!
                
                let note = notesDataSource[indexPath.row]
                
                let displayNoteViewController = segue.destinationViewController as! NoteContentViewController
                
                displayNoteViewController.note = note
                
            } else if segue.identifier == "addNote" {
                print("+ button tapped")
            }
    }

    
    @IBAction func unwindToToDoListViewController(segue: UIStoryboardSegue) {
        
    }

}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            RealmHelper.deleteNote(notesDataSource[indexPath.row])
            notesDataSource = RealmHelper.retrieveNotes()
        }
    }
}

extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let note = notesDataSource[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell") as! NoteTableViewCell
        cell.note = note
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesDataSource.count
    }
}
