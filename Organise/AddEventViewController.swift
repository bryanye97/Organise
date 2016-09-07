//
//  AddEventViewController.swift
//  Organise
//
//  Created by Bryan Ye on 3/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    var eventDate: NSDate?

    @IBOutlet weak var eventTitleTextField: UITextField!
    
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitleTextField.text = String(eventDate)
    }
}
