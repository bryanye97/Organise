//
//  CalendarViewController.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//


import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    let numberOfRows = 6
    let formatter = NSDateFormatter()
    let testCalendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    
    var selectedDate: NSDate!
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "MM/dd/yyyy"
        testCalendar.timeZone = NSTimeZone(abbreviation: "GMT")!
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.registerCellViewXib(fileName: "CalendarCellView")
        calendarView.cellInset = CGPoint(x: 0, y: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectDate() {
        for date in calendarView.selectedDates {
            selectedDate = date
            print(selectedDate)
        }
    }
    
    func selectTodaydate() {
        self.calendarView.selectDates([NSDate()], triggerSelectionDelegate: true)
    }
    
    func convertMonthIntegerToString(month: Int) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.monthSymbols
        let monthString = months[month-1]
        
        return monthString
    }
    
    func setupViewsOfCalendar(startDate: NSDate, endDate: NSDate) {
        let month = testCalendar.component(NSCalendarUnit.Month, fromDate: startDate)
        let monthName = NSDateFormatter().monthSymbols[(month-1) % 12]
        let year = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: startDate)
        monthLabel.text = monthName
        yearLabel.text = String(year)
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        guard let cellView = cell as? CalendarCellView else { return }
        
        cellView.setupCellBeforeDisplay(cellState, date: date)
        cellView.disableFollowingMonthDates(cellState)
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CalendarCellView)?.cellSelectionChanged(cellState)
        selectDate()
        setupViewsOfCalendar(date, endDate: date)
        
        if cellState.dateBelongsTo == .FollowingMonthWithinBoundary {
            self.calendarView.scrollToNextSegment()
        }
        
        if cellState.dateBelongsTo == .PreviousMonthWithinBoundary {
            self.calendarView.scrollToPreviousSegment()
        }
    }
    
    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CalendarCellView)?.cellSelectionChanged(cellState)
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, numberOfRows: Int, calendar: NSCalendar) {
        
        let firstDate = formatter.dateFromString("01/01/2016")
        let secondDate = formatter.dateFromString("01/01/2020")
        let aCalendar = NSCalendar.currentCalendar() 
        return (startDate: firstDate!, endDate: secondDate!, numberOfRows: numberOfRows, calendar: aCalendar)
    }
}