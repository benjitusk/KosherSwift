//
//  Calendar+Components.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Calendar {
    func weekOfMonth(date: Date) -> Int {
        return self.component(.weekOfMonth, from: date)
    }
    
    func weekOfYear(date: Date) -> Int {
        return self.component(.weekOfYear, from: date)
    }
    
    func weekdayNumber(date: Date) -> Int {
        return self.component(.weekday, from: date)
    }
    
    func weekdayOf(_ date: Date) -> Weekday {
        let dayIndex = weekdayNumber(date: date)
        return Weekday(rawValue: dayIndex)!
    }
    
    func secondsOfDate(date: Date) -> Int {
        return self.component(.second, from: date)
    }
    
    func minutesOfDate(date: Date) -> Int {
        return self.component(.minute, from: date)
    }
    
    func hoursOfDate(date: Date) -> Int {
        return self.component(.hour, from: date)
    }
    
    func daysOfDate(date: Date) -> Int {
        return self.component(.day, from: date)
    }
    
    func monthsOfDate(date: Date) -> Int {
        return self.component(.month, from: date)
    }
    
    func yearOfDate(date: Date) -> Int {
        return self.component(.year, from: date)
    }
    
    func eraOfDate(date: Date) -> Int {
        return self.component(.era, from: date)
    }
}
