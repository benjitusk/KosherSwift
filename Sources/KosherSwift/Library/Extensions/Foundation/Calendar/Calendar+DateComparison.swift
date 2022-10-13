//
//  Calendar+DateComparison.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Calendar {
    func date(_ lhs: Date, isSameDayAs rhs: Date) -> Bool {
        let firstDay = self.daysOfDate(date: lhs)
        let secondDay = self.daysOfDate(date: rhs)
        
        let sameMonth = date(lhs, isSameMonthAs: rhs)
        let sameDay = firstDay == secondDay
        
        return sameMonth && sameDay
    }
    
    func date(_ lhs: Date, isSameWeekAs rhs: Date) -> Bool {
        let firstMonth = weekOfYear(date: lhs)
        let secondMonth = weekOfYear(date: rhs)
        
        let sameMonth = firstMonth == secondMonth
        let sameYear = date(lhs, isSameYearAs: rhs)
        
        return sameMonth && sameYear
    }
    
    func date(_ lhs: Date, isSameMonthAs rhs: Date) -> Bool {
        let firstMonth = monthsOfDate(date: lhs)
        let secondMonth = monthsOfDate(date: rhs)
        
        let sameMonth = firstMonth == secondMonth
        let sameYear = date(lhs, isSameYearAs: rhs)
        
        return sameMonth && sameYear
    }
    
    func date(_ lhs: Date, isSameYearAs rhs: Date) -> Bool {
        let firstYear = yearOfDate(date: lhs)
        let secondYear = yearOfDate(date: rhs)
        
        let sameYear = firstYear == secondYear
        let sameEra = date(lhs, isSameEraAs: rhs)
        
        return sameYear && sameEra
    }
    
    func date(_ lhs: Date, isSameEraAs rhs: Date) -> Bool {
        let firstEra = eraOfDate(date: lhs)
        let secondEra = eraOfDate(date: rhs)
        
        return firstEra == secondEra
    }
    
}
