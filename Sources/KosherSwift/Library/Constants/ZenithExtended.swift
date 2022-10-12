//
//  File.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants.Zenith {
    /** kZenithSixteenPointOne
     *
     *  The zenith of 16.1 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for determining *alos* (dawn) and *tzais* (nightfall)
     *  in some opinions. It is based on the calculation that the time between dawn
     *  and sunrise (and sunset to nightfall) is 72 minutes, the time that is takes to
     *  walk 4 *mil* at 18 minutes a mil (*Rambam* and others). The sun's position at 72
     *  minutes before sunrise in Jerusalem on the equinox is 16.1 degrees below geometric zenith.
     */
    static let sixteenPointOne: Float = Constants.Zenith.geometric + 16.1
    
    /** kZenithEightPointFive
     *
     *  The zenith of 8.5 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *alos* (dawn) and *tzais* (nightfall) in some opinions.
     *  This calculation is based on the position of the sun 36 minutes after sunset in Jerusalem
     *  on March 16, about 4 days before the equinox, the day that a
     *  solar hour is 60 minutes, which is 8.5degrees below geometric zenith. The Ohr Meir
     *  considers this the time that 3 small stars are visible, which is later than the
     *  required 3 medium stars.
     */
    static let eightPointFive: Float = Constants.Zenith.geometric + 8.5
    
    /** kZenithThreePointSeven
     *
     *  The zenith of 3.7 degrees below geometric zenith (90 degrees).
     *  This calculation is used for calculating *tzais* (nightfall) based on the opinion of
     *  the *Geonim* that *tzais* is the time it takes to walk 3/4 of a *Mil*
     *  at 18 minutes a *Mil*, or 13.5 minutes after sunset. The sun is 3.7 degrees below
     *  geometric zenith at this time in Jerusalem on March 16,
     *  about 4 days before the equinox, the day that a solar hour is 60 minutes.
     */
    static let threePointSeven: Float = Constants.Zenith.geometric + 3.7
    
    /** kZenithFivePointNinetyFive
     *
     *  The zenith that is 5.95 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *tzais* (nightfall) according to some opinions.
     *  This calculation is based on the position of the sun 24 minutes after sunset in Jerusalem
     *  on March 16, about 4 days before the equinox, the day that a solar hour is 60 minutes,
     *  which calculates to 5.95 degrees below geometric zenith.
     */
    static let fivePointNinetyFive: Float = Constants.Zenith.geometric + 5.95
    
    /** kZenithSevenPointZeroEightThree
     *
     *  The zenith of 7.083 degrees below geometric zenith (90 degrees).
     *
     *  This is often referred to as 7 degrees and 5 minutes. This calculation is used for
     *  calculating *alos* (dawn) and *tzais* (nightfall) according to some opinions. This
     *  calculation is based on the position of the sun 30
     *  minutes after sunset in Jerusalem on March 16, about 4 days before the equinox, the day that
     *  a solar hour is 60 minutes, which calculates to 7.0833333 degrees below geometric zenith.
     *  This is time some opinions consider dark enough for 3 stars to be visible.
     *  This is the opinion of the *Sh"Ut Melamed Leho'il*, *Sh"Ut Binyan Tziyon*,
     *  *Tenuvas Sadeh* and very close to the time of the *Mekor Chesed* on
     *  the *Sefer chasidim*.
     */
    static let sevenPointZeroEightThree: Float = Constants.Zenith.geometric + 7 + (5/60)
    
    /** kZenithTenPointTwo
     *
     *  The zenith of 10.2 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *misheyakir* according to some opinions.
     *  This calculation is based on the position of the sun 45 minutes sunrise in Jerusalem on
     *  March 16, about 4 days before the equinox, the day that a solar hour is 60 minutes, which
     *  calculates to 10.2 degrees below geometric zenith.
     */
    static let tenPointTwo: Float = Constants.Zenith.geometric + 10.2
    
    /** kZenithElevenDegrees
     *
     * The zenith of 11 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *misheyakir* according to some
     *  opinions. This calculation is based on the position of the sun 48 minutes before
     *  sunrise in Jerusalem on March 16, about 4 days before the
     *  equinox, the day that a solar hour is 60 minutes which calculates to 11 degrees
     *  below geometric zenith
     */
    static let elevenDegrees: Float = Constants.Zenith.geometric + 11
    
    /** kZenithElevenPointFive
     *
     *  The zenith of 11.5 degrees below geometric zenith. (90 degrees).
     *
     *  This calculation is used for calculating *misheyakir*
     *  according to some opinions. This calculation is based on the
     *  position of the sun 52 minutes before sunrise in Jerusalem on
     *  March 16, about 4 days before the equinox, the day that a solar hour
     *  is 60 minutes which calculates to 11.5 degrees below geometric zenith.
     */
    static let elevenPointFive: Float = Constants.Zenith.geometric + 11.5
    
    /** kZenithThirteenDegrees
     *
     *  The zenith of 13 degrees below geometric zenith. (90 degrees).
     *
     *  No further details were available in KosherJava.
     */
    static let thirteenDegrees: Float = Constants.Zenith.geometric + 13
    
    /** kZenithThirteenPointTwentyFourDegrees
     *
     *  The zenith of 13.24 degrees below geometric zenith (90 degrees).
     *  This calculation is used for calculating *Rabainu Tam's bain hashmashos*
     *  according to some opinions. <br/>
     *
     *  NOTE: See comments on bainHashmashosRT13Point24Degrees for additional
     *  details about the degrees.
     */

    static let thirteenPointTwentyFourDegrees: Float = Constants.Zenith.geometric + 13.24

    /** kZenithNineteenPointEight
     *
     * The zenith of 19.8 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *alos* (dawn) and *tzais* (nightfall)
     *  according to some opinions. This calculation is based on the position of the sun
     *  90 minutes after sunset in Jerusalem on March 16, about 4 days before the
     *  equinox, the day that a solar hour is 60 minutes which calculates to 19.8 degrees
     *  below geometric zenith
     *
     * @see tzais19Point8Degrees
     * @see alos19Point8Degrees
     * @see alos90
     * @see tzais90
     *
     */

    static let nineteenPointEight: Float = Constants.Zenith.geometric + 19.8

    /** kZenithTwentySix
     *
     *  The zenith of 26 degrees below geometric zenith (90 degrees).
     *  This calculation is used for calculating *alos* (dawn) and *tzais* (nightfall)
     *  according to some opinions. This calculation is based on the position of the
     *  sun 120 minutes after sunset in Jerusalem on March 16,
     *  about 4 days before the equinox, the day that a solar hour is 60 minutes which
     *  calculates to 26 degrees below geometric zenith
     *
     * @see alos26Degrees
     * @see tzais26Degrees
     * @see alos120
     * @see tzais120
     */

    static let twentySix: Float = Constants.Zenith.geometric + 26.0

    /**
     *  In KosherJava, this was marked experimentimal and might not
     *  make the 1.3 version of the API.
     */

    /** kZenithFourPointThirtySeven
     *
     *  The zenith of 4.37 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for  calculating *tzais* (nightfall)
     *  according to some opinions. This calculation is based on the position of the
     *  sun tzaisGeonim4Point37Degrees 16 7/8 minutes after sunset (3/4 of a 22.5
     *  minute Mil) Jerusalem on March 16, about 4 days before the equinox, the day that
     *  a solar hour is 60 minutes which calculates to 4.37 degrees below geometric zenith.
     */

    static let fourPointThirtySeven: Float = Constants.Zenith.geometric + 4.37

    /** kZenithFourPointSixtyOne
     *
     * The zenith of 4.61 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *tzais* (nightfall) according to some opinions.
     *  This calculation is based on the position of the sun tzaisGeonim4Point37Degrees
     *  18 minutes after sunset (3/4 of a 24 minute Mil) in Jerusalem on March 16,
     *  about 4 days before the equinox, the day that a solar hour is 60 minutes which
     *  calculates to 4.61 degrees below geometric zenith
     *
     *  @see tzaisGeonim4Point61Degrees
     */

    static let fourPointSixtyOne: Float = Constants.Zenith.geometric + 4.61

    /** kZenithFourPointEight
     *
     *  The zenith of 4.8 degrees below geometric zenith (90 degrees)
     *
     *  No further details were available in KosherJava.
     */

    static let fourPointEight: Float = Constants.Zenith.geometric + 4.8

    /** kZenithThreePointSixtyFive
     *
     * The zenith of 3.65 degrees below geometric zenith (90 degrees).
     *
     *  This calculation is used for calculating *tzais* (nightfall) according
     *  to some opinions. This calculation is based on the position of the sun tzaisGeonim3Point65Degrees
     *  13.5 minutes after sunset (3/4 of an 18 minute Mil) in Jerusalem on March 16, about
     *  4 days before the equinox, the day that a solar hour is 60 minutes which calculates to
     *  3.65 degrees below geometric zenith
     *
     *  @see tzaisGeonim3Point65Degrees
     */

    static let threePointSixtyFive: Float = Constants.Zenith.geometric + 3.65

    /** kZenithFivePointEightyEight
     *
     *  The zenith of 5.88 degrees below geometric zenith (90 degrees).
     *
     *  No further details were available in KosherJava.
     */

    static let fivePointEightyEight: Float = Constants.Zenith.geometric + 5.88
}
