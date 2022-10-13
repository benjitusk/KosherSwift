//
//  Calendar+HebrewYearTypes.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation
extension Calendar {
    static func hebrewCalendar() -> Calendar {
        return Calendar(identifier: .hebrew)
    }
    
    static func firstWeekdayOfHebrewYear(of date: Date) -> Weekday {
        let hCalendar = hebrewCalendar()
        let hYear = hCalendar.yearOfDate(date: date)
        let roshHashana = hCalendar.date(from: DateComponents(year: hYear, month: 1, day: 1))!
        return hCalendar.weekdayOf(roshHashana)
    }
    
    static func lengthOfHebrewYear(of date: Date) -> HebrewYearLength {
        let hCalendar = Calendar.hebrewCalendar()
        let hYear = hCalendar.yearOfDate(date: date)
        
        let previousRoshHashana = hCalendar.date(from: DateComponents(year: hYear, month: 1, day: 1))!
        let nextRoshHashana = hCalendar.date(from: DateComponents(year: hYear+1, month: 1, day: 1))!
        
        let length = hCalendar.dateComponents([.day], from: previousRoshHashana, to: nextRoshHashana).day!
        // The last digit is always 3, 4, or 5,
        // corresponding to a short, regular, or long year,
        // So we only really care about the last digit
        let lastDigit = length % 10
        
        switch lastDigit {
        case 3:
            return .short
        case 4:
            return .regular
        case 5:
            return .long
        default:
            fatalError("Unable to calculate hebrew year \(hYear) containing \(length) days!")
        }
        
    }
    
    static func isHebrewLeapYear(of date: Date) -> Bool {
        let hCalendar = Calendar.hebrewCalendar()
        let hYear = hCalendar.yearOfDate(date: date)
        
        let previousRoshHashana = hCalendar.date(from: DateComponents(year: hYear, month: 1, day: 1))!
        let nextRoshHashana = hCalendar.date(from: DateComponents(year: hYear+1, month: 1, day: 1))!
        
        let months = Calendar.hebrewCalendar().dateComponents([.month], from: previousRoshHashana, to: nextRoshHashana).month!
        return months == 13
    }
    
    static func hebrewYearType(of date: Date) -> HebrewYearType {
        let weekday = firstWeekdayOfHebrewYear(of: date)
        let yearLength = lengthOfHebrewYear(of: date)
        let isLeapYear = isHebrewLeapYear(of: date)
        
        if (!isLeapYear) {
            //  ...that are short years...
            if (yearLength == .short) {
                //  ...that begin on Monday are type A
                if (weekday == .Monday) {
                    return .hebrewYearTypeA;
                }
                
                //  ...that begin on Saturday are type B
                else if(weekday == .Saturday) {
                    return .hebrewYearTypeB;
                }
            }
            
            //  ...that are regular years...
            else if (yearLength == .short) {
                //  ...that begin on Tuesday are type C
                if (weekday == .Tuesday) {
                    return .hebrewYearTypeC;
                }
                
                // ...that begin on Thursday are type D
                else if (weekday == .Thursday) {
                    return .hebrewYearTypeD;
                }
            }
            
            // ...that are long years...
            else if (yearLength == .long) {
                
                //  ...that begin on Monday are type E
                if (weekday == .Monday) {
                    return .hebrewYearTypeE;
                }
                
                //  ...that begin on Thursday are type F
                else if (weekday == .Thursday) {
                    return .hebrewYearTypeF;
                }
                
                //  ...that begin on Saturday are type G
                else if (weekday == .Saturday) {
                    return .hebrewYearTypeG;
                }
            }
        }
        
        //  The next 7 types of years are leap years. Leap years...
        else if (isLeapYear) {
            //  ...that are short years...
            if (yearLength == .short) {
                //  ...that begin on Monday are type H.
                if (weekday == .Monday) {
                    return .hebrewYearTypeH;
                }
                
                //  ...that begin on Thursday are type I.
                else if (weekday == .Thursday) {
                    return .hebrewYearTypeI;
                }
                
                //  ...that begin on Saturday are type J.
                else if (weekday == .Saturday) {
                    return .hebrewYearTypeJ;
                }
            }
            
            //  ...that are regular years...
            else if (yearLength == .regular) {
                //  ...that begin on Tuesdat are type K
                if (weekday == .Tuesday) {
                    return .hebrewYearTypeK;
                }
            }
            
            //  ...that are long years...
            else if(yearLength == .long) {
                //  ...that begin on Monday are type L
                if (weekday == .Monday) {
                    return .hebrewYearTypeL;
                }
                
                //  ...that begin on Thursday are type M
                else if (weekday == .Thursday) {
                    return .hebrewYearTypeM;
                }
                
                //  ...that begin on Saturday are type N
                else if (weekday == .Saturday) {
                    return .hebrewYearTypeN;
                }
            }
        }
        fatalError("Could not calculate type of Hebrew Year \(Calendar.hebrewCalendar().yearOfDate(date: date)) containing \(yearLength) days")
    }
    
}


enum HebrewYearType {
    case hebrewYearTypeA    //  Monday,     353, regular
    case hebrewYearTypeB    //  Shabbat,    353, regular
    case hebrewYearTypeC    //  Tuesday,    354, regular
    case hebrewYearTypeD    //  Thursday,   354, regular
    case hebrewYearTypeE    //  Monday,     355, regular
    case hebrewYearTypeF    //  Thursday,   355, regular
    case hebrewYearTypeG    //  Shabbat,    355, regular    -----
    case hebrewYearTypeH    //  Monday,     383, leap       -----
    case hebrewYearTypeI    //  Thursday,   383, leap
    case hebrewYearTypeJ    //  Shabbat,    383, leap
    case hebrewYearTypeK    //  Tuesday,    384, leap
    case hebrewYearTypeL    //  Monday,     385, leap
    case hebrewYearTypeM    //  Thursday,   385, leap
    case hebrewYearTypeN    //  Shabbat,    385, leap
}

enum Weekday: Int {
    case Sunday = 0
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

enum HebrewYearLength {
    case short              //  Years that are 353/383 days long
    case regular            //  Years that are 354/384 days long
    case long               //  Years that are 355/385 days long
}
