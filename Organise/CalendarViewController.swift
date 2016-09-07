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
    
    let numberOfRows = 5
    let formatter = NSDateFormatter()
    let testCalendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    var selectedDate: NSDate?
    
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
        
        calendarView.direction = .Horizontal
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.allowsMultipleSelection = false
        calendarView.firstDayOfWeek = .Sunday
        calendarView.scrollEnabled = true
        calendarView.scrollingMode = .StopAtEachCalendarFrameWidth
        calendarView.itemSize = nil
        calendarView.rangeSelectionWillBeUsed = false
        calendarView.reloadData()

        calendarView.scrollToDate(NSDate(), triggerScrollToDateDelegate: true, animateScroll: false) {
            self.selectTodaysDate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func selectTodaysDate() {
        let date = NSDate()
        calendarView.selectDates([date])
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
    
    func selectDate() {
        for date in calendarView.selectedDates {
            selectedDate = date
            print(selectedDate)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addEvent" {
            let destinationViewController = segue.destinationViewController as! AddEventViewController
            guard let selectedDate = selectedDate else { return }
            destinationViewController.eventDate = selectedDate
        }
    }
    
    @IBAction func unwindToCalendarViewController(segue: UIStoryboardSegue) {
        
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
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        setupViewsOfCalendar(startDate, endDate: endDate)
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