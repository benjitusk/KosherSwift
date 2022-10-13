//
//  Date+ConvenientDates.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Date {
    static func dateWithHebrew(day: Int, month: Int, year: Int?=nil) -> Date {
        let hCalendar = Calendar.hebrewCalendar()
        let year = year ?? hCalendar.yearOfDate(date: Date())
        var components = DateComponents()
        components.calendar = hCalendar
        components.day = day
        components.month = month
        components.year = year
        
        return hCalendar.date(from: components)!
    }
}
