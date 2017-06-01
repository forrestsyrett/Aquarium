//
//  EventsViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 5/31/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JTAppleCalendar
import AlamofireObjectMapper



class EventsViewController: UIViewController {
    
  //  @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    @IBOutlet weak var monthLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    
    var currentDate = Date()
    
    let outsideMonthColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    let monthColor = UIColor.white
    let dateFormatter = DateFormatter()
    
    
    var calendarEvents: [Event] = []
    var month = ""
    var monthIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendar()
        gradient(self.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        IndexController.shared.index = (self.tabBarController?.selectedIndex)!

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupCalendar() {
        
        //Set currentDate
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        
        self.currentDate = calendar.date(from: components)!
        print("CurrentDate \(currentDate)")
        
        calendarView.scrollToDate(currentDate)
        calendarView.selectDates([currentDate])
        
        //Setup Calendar Spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        
        calendarView.layer.borderColor = UIColor.white.cgColor
        calendarView.layer.borderWidth = 1.0
        
        //setup labels
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    
    
    
    
      func animateTableView() {
        
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        
        for eventCell in cells {
            let cell: UITableViewCell = eventCell as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            index += 1
        }
        
    }
    
    
    
    
    
    
    /////////////////////////////////////////////
    func getCalendarItems(completionHandler: @escaping (Bool) -> ()) {
        
        let calendar = Calendar.current
        self.calendarEvents = []
        
        let currentDate = self.currentDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        let dateTimeMin = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: currentDate)
        
        let dateTimeMax = calendar.date(bySettingHour: 23, minute: 59, second: 0, of: dateTimeMin!)
        
        let timeMin = formatter.string(from: dateTimeMin!)
        let timeMax = formatter.string(from: dateTimeMax!)
        
        
        print(timeMin)
        print(timeMax)
        
        
        let body : Parameters  = [
            "calendarId" : "ahyde1973@gmail.com",
            "singleEvents": "true",
            "timeMin": timeMin,
            "timeMax": timeMax,
            "orderBy": "startTime"
        ]
        let calendarId: String = "ahyde1973@gmail.com"
        let apiKey: String = "AIzaSyCRN-lvkpHLtGj8ZX_gkHXkM7O16RTUn_w"
        let urlFormat: String = "https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,summary,status)"
        let calendarUrl = String(format: urlFormat, calendarId, apiKey)
        
        Alamofire.request(calendarUrl, parameters: body).responseObject { (response: DataResponse<AllEvents>) in
            print("EXECUTING...")
            self.activityMonitor.isHidden = false
            self.activityMonitor.startAnimating()
            switch response.result {
            case .success:
                guard let event = response.result.value else { return }
                
                print(event)
                guard let events = event.events else { return }
                
                for singleEvent in events {
                    self.calendarEvents.append(singleEvent)
                    //      print("EventName: \(singleEvent.eventName)")
                }
                
                self.animateTableView()
                
                
            case .failure(let error):
                print(error)
                
            }
            completionHandler(true)
        }
    }
    
    
    ////////////////////////////////////////////
    
    func getDate(dateString: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy, HH:mm"
        let date = formatDate(dateString: dateString)
        let newDate = formatter.date(from: date)!
        
        return newDate
    }
    
    
    
    
    
    func formatDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        
        let cleanDateFormat = DateFormatter()
        cleanDateFormat.dateStyle = .none
        cleanDateFormat.timeStyle = .short
        
        
        let newDate = (formatter.date(from: dateString)!)
        
        
        let cleanDate = cleanDateFormat.string(from: newDate)
        
        return cleanDate
        
    }
    
    
    
    func handleCellSelected(cell: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = cell as? CustomCell else { return }
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else { return }
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = .black
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = self.monthColor
            } else {
                validCell.dateLabel.textColor = self.outsideMonthColor
            }
        }
    }
    
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        
        
        guard let date = visibleDates.monthDates.first?.date else { return }
        
     //   self.dateFormatter.dateFormat = "yyyy"
       // self.yearLabel.text = self.dateFormatter.string(from: date)
        
        
        self.dateFormatter.dateFormat = "MMMM"
        self.monthLabel.text = self.dateFormatter.string(from: date)
    }
    
    
}


extension EventsViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let startDate = dateFormatter.date(from: "2017 01 01")!
        let endDate = dateFormatter.date(from: "2017 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1, calendar: nil, generateInDates: nil, generateOutDates: nil, firstDayOfWeek: nil, hasStrictBoundaries: nil)
        return parameters
    }
    
}


extension EventsViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        
        
        if cellState.dateBelongsTo == .followingMonthWithinBoundary || cellState.dateBelongsTo == .previousMonthWithinBoundary {
            calendar.scrollToDate(date)
        }
        
        self.currentDate = cellState.date
        
        getCalendarItems { (true) in
            print("Execution Finished")
            if self.calendarEvents.count != 0 {
                self.activityMonitor.stopAnimating()
                self.activityMonitor.isHidden = true
            } else {
                return
            }
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
}



extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.calendarEvents.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        let event = self.calendarEvents[indexPath.row]
        
        
        cell.eventNameLabel.text = event.eventName
        
        guard let eventDate = event.eventDate else {
            
            cell.eventTimeLabel.text = ""
            
            return cell
            
        }
        cell.eventTimeLabel.text = self.formatDate(dateString: eventDate)
        
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
}


