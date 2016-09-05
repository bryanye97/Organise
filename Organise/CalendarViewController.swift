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
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.registerCellViewXib(fileName: "CalendarCellView")
        calendarView.cellInset = CGPoint(x: 0, y: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertMonthIntegerToString(month: Int) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.monthSymbols
        let monthString = months[month-1]
        
        return monthString
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate  {
    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, numberOfRows: Int, calendar: NSCalendar) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let firstDate = formatter.dateFromString("2016 01 05")
        let secondDate = NSDate()
        let numberOfRows = 6
        let aCalendar = NSCalendar.currentCalendar()
        let components = aCalendar.components([.Day , .Month , .Year], fromDate: secondDate)
        
        let year =  components.year
        let month = components.month
        
        
        
        monthLabel.text = convertMonthIntegerToString(month)
        yearLabel.text = String(year)
        
        return (startDate: firstDate!, endDate: secondDate, numberOfRows: numberOfRows, calendar: aCalendar)
    }
    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        (cell as! CalendarCellView).setupCellBeforeDisplay(cellState, date: date)
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as! CalendarCellView).didSelectCell(cellState, date: date)
    }
    
    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as! CalendarCellView).didDeselectCell(cellState, date: date)
    }
    
}