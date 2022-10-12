//
//  Calendar+DateComparison.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Calendar {
    func date(_ lhs: Date, isSameDayAs rhs: Date) -> Bool {
        let firstDay = self.daysInDate(date: lhs)
        let secondDay = self.daysInDate(date: rhs)
        
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
        let firstMonth = monthsInDate(date: lhs)
        let secondMonth = monthsInDate(date: rhs)
        
        let sameMonth = firstMonth == secondMonth
        let sameYear = date(lhs, isSameYearAs: rhs)
        
        return sameMonth && sameYear
    }
    
    func date(_ lhs: Date, isSameYearAs rhs: Date) -> Bool {
        let firstYear = yearsInDate(date: lhs)
        let secondYear = yearsInDate(date: rhs)
        
        let sameYear = firstYear == secondYear
        let sameEra = date(lhs, isSameEraAs: rhs)
        
        return sameYear && sameEra
    }
    
    func date(_ lhs: Date, isSameEraAs rhs: Date) -> Bool {
        let firstEra = eraInDate(date: lhs)
        let secondEra = eraInDate(date: rhs)
        
        return firstEra == secondEra
    }
    
}
