//
//  CalendarCellView.swift
//  Organise
//
//  Created by Bryan Ye on 3/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import JTAppleCalendar
class CalendarCellView: JTAppleDayCellView {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet weak var selectedCellView: UIView!
    
    var normalDayColor = UIColor.blackColor()
    var weekendDayColor = UIColor.grayColor()
    
    
    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        dayLabel.text =  cellState.text
        configureTextColor(cellState)
        
        if cellState.isSelected {
            selectedCellView.hidden = false
        } else {
            selectedCellView.hidden = true
        }
    }
    
    func didSelectCell(cellState: CellState, date: NSDate) {
        selectedCellView.hidden = false
        selectedCellView.backgroundColor = UIColor.organiseRedColor()
    }
    
    func didDeselectCell(cellState: CellState, date: NSDate) {
        selectedCellView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .ThisMonth {
            dayLabel.textColor = normalDayColor
        } else {
            dayLabel.textColor = weekendDayColor
        }
    }
    
    override func awakeFromNib() {
        selectedCellView.layer.cornerRadius = 25
    }
    
}