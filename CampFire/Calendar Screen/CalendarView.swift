//
//  CalendarView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/20/23.
//

import UIKit

class CalendarView: UIView, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
    }
    
    var calendarView: UICalendarView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemBackground
        
        setupCalendarView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCalendarView(){
        calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        self.addSubview(calendarView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            calendarView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    
    

}
