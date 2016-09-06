//
//  CalendarCellView.swift
//  Organise
//
//  Created by Bryan Ye on 3/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import JTAppleCalendar
class CalendarCellView: JTAppleDayCellView {
    
    @IBInspectable var todayColor: UIColor!// = UIColor(red: 254.0/255.0, green: 73.0/255.0, blue: 64.0/255.0, alpha: 0.3)
    @IBInspectable var normalDayColor: UIColor! //UIColor(white: 0.0, alpha: 0.1)
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet weak var selectedCellView: UIView!
    
    let textSelectedColor = UIColor(colorWithHexValue: 0xffffff)
    let textDeselectedColor = UIColor.blackColor()
    let previousMonthTextColor = UIColor.grayColor()
    lazy var todayDate : String = {
        [weak self] in
        let aString = self!.c.stringFromDate(NSDate())
        return aString
        }()
    
    lazy var c : NSDateFormatter = {
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        
        return f
    }()

    
    func cellSelectionChanged(cellState: CellState) {
        if cellState.isSelected == true {
            if selectedCellView.hidden == true {
                configureViewIntoBubbleView(cellState)
                selectedCellView.animateWithBounceEffect(withCompletionHandler: {
                })
            }
        } else {
            configureViewIntoBubbleView(cellState, animateDeselection: true)
        }
    }
    
    func configureViewIntoBubbleView(cellState: CellState, animateDeselection: Bool = false) {
        if cellState.isSelected {
            self.selectedCellView.layer.cornerRadius =  self.selectedCellView.frame.width  / 2
            self.selectedCellView.hidden = false
            configureTextColor(cellState)
            
        } else {
            if animateDeselection {
                configureTextColor(cellState)
                if selectedCellView.hidden == false {
                    selectedCellView.animateWithFadeEffect(withCompletionHandler: { () -> Void in
                        self.selectedCellView.hidden = true
                        self.selectedCellView.alpha = 1
                    })
                }
            } else {
                selectedCellView.hidden = true
            }
        }
    }
    
    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        // Setup Cell text
        dayLabel.text =  cellState.text
        
        // Setup text color
        configureTextColor(cellState)
        
        // Setup Cell Background color
        //        self.todayView.layer.cornerRadius = self.frame.width / 2
        //        self.layer.cornerRadius = self.frame.width  / 2
        //        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = c.stringFromDate(date) == todayDate ? todayColor:normalDayColor
//        eventNotificationView.layer.cornerRadius = 3
        
        
        // Setup cell selection status
        delayRunOnMainThread(0.0) {
            self.configureViewIntoBubbleView(cellState)
        }
        
        // Configure Visibility
        configureVisibility(cellState)
    }
    
    func configureVisibility(cellState: CellState) {
        if cellState.dateBelongsTo == .ThisMonth ||
                cellState.dateBelongsTo == .PreviousMonthWithinBoundary ||
                cellState.dateBelongsTo == .FollowingMonthWithinBoundary {
            self.hidden = false
        } else {
            self.hidden = false
        }
        
    }
    
    func delayRunOnMainThread(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func disableFollowingMonthDates(cellState: CellState) {
        if cellState.dateBelongsTo == .FollowingMonthOutsideBoundary {
            self.hidden = true
        } else {
            self.hidden = false
        }
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.isSelected {
            dayLabel.textColor = textSelectedColor
        } else if cellState.dateBelongsTo == .ThisMonth {
            dayLabel.textColor = textDeselectedColor
        } else {
            dayLabel.textColor = previousMonthTextColor
            
        }
    }
    
    override func awakeFromNib() {
        selectedCellView.layer.cornerRadius = 50
    }
    
}