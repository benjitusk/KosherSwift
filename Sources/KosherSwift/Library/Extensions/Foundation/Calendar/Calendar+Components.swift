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
    
    func secondsInDate(date: Date) -> Int {
        return self.component(.second, from: date)
    }
    
    func minutesInDate(date: Date) -> Int {
        return self.component(.minute, from: date)
    }
    
    func hoursInDate(date: Date) -> Int {
        return self.component(.hour, from: date)
    }
    
    func daysInDate(date: Date) -> Int {
        return self.component(.day, from: date)
    }
    
    func monthsInDate(date: Date) -> Int {
        return self.component(.month, from: date)
    }
    
    func yearsInDate(date: Date) -> Int {
        return self.component(.year, from: date)
    }
    
    func eraInDate(date: Date) -> Int {
        return self.component(.era, from: date)
    }
}
