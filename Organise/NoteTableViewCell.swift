//
//  NoteTableViewCell.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var note: Note? {
        didSet {
            guard let note = note else { return }
            titleLabel.text = note.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
