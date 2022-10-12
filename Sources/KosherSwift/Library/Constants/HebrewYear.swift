//
//  File.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants {
    
    /**
     The three kinds of Hebrew years.

     Another way of thinking about this is a composite
     of leap years (with 13 months instead of 12) and
     leap months. (Leap months contain 30 days instead
     of the 29 they would otherwise contain. Two months
     of the Hebrew calendar can be leap months.)
     */
    enum HebrewYearType: Int {
        /**
         KCYearTypeChaser: A "defective" year has either 353 days long, or in a leap year, 383 days.
         */
        case Chaser
        /**
         KCYearTypeKesidran: A "common" year is 354 days long, or in a leap year, 384 days.
         */
        case Kesidran
        /**
         KCYearTypeShalaim: A "complete" year is 355 days long, or in a leap year, 383 days
         */
        case Shalaim
    }
}
