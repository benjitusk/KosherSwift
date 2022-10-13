//
//  Calendar+Juncture.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Calendar {
    var firstDayOfWeek: Date? {
        return firstDayOfWeekUsingReferenceDate(Date())
    }

    func firstDayOfWeekUsingReferenceDate(_ date: Date) -> Date? {
        let weekday = weekdayNumber(date: date) - 1
        return self.date(byAdding: .weekday, value: weekday, to: date)
    }
    
    var lastDayOfWeek: Date? {
        return lastDayOfWeekUsingReferenceDate(Date())
    }
    
    func lastDayOfWeekUsingReferenceDate(_ date: Date) -> Date? {
        let firstDay = firstDayOfWeekUsingReferenceDate(date)!
        let nextWeek = self.date(byAdding: .weekOfYear, value: 1, to: date)!
        let daysPerWeek = self.dateComponents([.day], from: firstDay, to: nextWeek).day!
        return self.date(byAdding: .day, value: daysPerWeek-1, to: date)
    }
    
    var firstDayOfMonth: Date? {
        return firstDayOfMonthUsingReferenceDate(Date())
    }
    
    func firstDayOfMonthUsingReferenceDate(_ date: Date) -> Date? {
        return self.date(from: self.dateComponents([.year, .month], from: self.startOfDay(for: date)))
    }
    
    var lastDayOfMonth: Date? {
        return lastDayOfMonthUsingReferenceDate(Date())
    }
    
    func lastDayOfMonthUsingReferenceDate(_ date: Date) -> Date? {
        guard let firstDayOfGivenMonth = firstDayOfMonthUsingReferenceDate(date) else { return nil }
        return self.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: firstDayOfGivenMonth
        )
    }
    
}
