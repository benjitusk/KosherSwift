//
//  AstronomicalCalculator.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
protocol AstronomicalCalculator {
    
    /**
     *  A method that calculates UTC sunrise as well as any time based on an angle above or below sunrise. This abstract
     *  method is implemented by the classes that extend this class.
     *
     *  @param date Used to calculate day of year.
     *  @param zenith the azimuth below the vertical zenith of 90 degrees. for sunrise typically the zenith used for
     *  the calculation uses geometric zenith of 90 degrees and adjusts this slightly to account for solar refraction
     *  and the sun's radius. Another example would be beginNauticalTwilight that passes NAUTICAL_ZENITH to this method.
     *  @param adjustForElevation Determines if we calculate at sea level or the altitude of the calculator's location.
     *  @return The number of milliseconds since
     */
    func UTCSunriseForDate(date: Date, zenith: Double, adjustForElevation: Bool) -> Double?
    
    /**
     *  A method that calculates UTC sunrise as well as any time based on an angle above or below sunset. This abstract
     *  method is implemented by the classes that extend this class.
     *
     *  @param date Used to calculate day of year.
     *  @param zenith the azimuth below the vertical zenith of 90 degrees. for sunrise typically the zenith used for
     *  the calculation uses geometric zenith of 90 degrees and adjusts this slightly to account for solar refraction
     *  and the sun's radius. Another example would be beginNauticalTwilight that passes NAUTICAL_ZENITH to this method.
     *  @param adjustForElevation Determines if we calculate at sea level or the altitude of the calculator's location.
     *
     *  @return The UTC time of sunrise in 24 hour format. 5:45:00 AM will return 5.75.0. If an error was encountered in
     *  the calculation (expected behavior for some locations such as near the poles, nil will be returned.
     */
    func UTCSunsetForDate(date: Date, zenith: Double, adjustForElevation: Bool) -> Double?
}
