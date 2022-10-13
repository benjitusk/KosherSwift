//
//  Date+Description.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Date {
    var description: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
    
    func dayNameFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "ccc"
        return formatter.string(from: self)
    }
    
    func monthNameFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }

    func monthAndYearFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }

    func monthAbbreviationAndYearFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }


    func monthAbbreviationFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }

    func monthAndDayFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }

    func dayOfMonthFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }

    func monthAndDayAndYearFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "MMM d yyyy"
        return formatter.string(from: self)
    }


    func dayOfMonthAndYearFor(calendar: Calendar) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "d yyyy"
        return formatter.string(from: self)
    }
}
