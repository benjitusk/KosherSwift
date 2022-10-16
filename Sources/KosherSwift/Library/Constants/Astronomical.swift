//
//  File.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants {
    
    /** kDegreesPerHour
     *
     *  This is defined as 360.0 / 24.0. There are 24 hours in a day and 360 degrees per day.
     */
    static let degreesPerHour: Double = 360.0 / 24.0
    
    /** kSolarRadius
     *
     *  The commonly used average solar radius in minutes of a degree.
     *
     */
    static let solarRadius: Double = 16.0 / 60.0
    
    /** kRefraction
     *
     *  The commonly used average solar refraction.
     *
     *  Calendrical Calculations lists a more accurate global average of 34.478885263888294.
     */
    static let refraction: Double = 34.0 / 60.0
    
    /** kEarthRadiusInKilometers
     *
     *  The diameter of the earth's radius in kilometers.
     */
    static let earthRadiusInKilometers: Double = 6356.9
}
