//
//  File 2.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants {
    
    /** kJewishEpoch
     *
     *  The Jewish epoch using the RD (Rata Die/Fixed Date or Reingold Dershowitz) day
     *  used in the Java version of the Calendrical Calculations.
     *  Day 1 is January 1, 0001 Gregorian
     */
    static let jewishEpoch = -1373429
    
    /** kChalakimPerMinute
     *
     *  The number of *chalakim* per minute.
     *
     *  This is defined as 18.
     */
    static let chalakimPerMinute = 18
    
    /** kChalakimPerHour
     *
     *  The number of *chalakim* per hour.
     *
     *  This is defined as 18 times the number of minutes per
     *  hour, or 1080.
     */
    static let chalakimPerHour = chalakimPerMinute * 60
    
    /** kChalakimPerDay
     *
     *  The number of *chalakim* per day.
     *
     *  This is defined as 18 times the number of minutes per
     *  hour times the number of hours per day, or 25920.
     */
    static let chalakimPerDay = chalakimPerHour * 24
    
    /** kChalakimPerMonth
     *
     *  The number of *chalakim* per month.
     *
     *  This is defined as the number of *chalakim*
     *  per day times the number of days in a standard
     *  Hebrew months.
     */
    static let chalakimPerMonth = 765433 // (29 * 24 + 12) * 1080 + 793
    
    /** kChalakimMoladTohu
     *
     *  Days from the beginning of Sunday till molad BaHaRaD.
     *
     *  Calculated as 1 day, 5 hours and 204 chalakim.
     *
     *  (24 + 5) *1080 + 204 = 31524
     */
    static let chalakimMoladTohu = 31524
}
