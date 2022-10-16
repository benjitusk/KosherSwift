//
//  AstronomicalCalendar.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation

class AstronomicalCalendar {
    var astronomicalCalculator: SunriseAndSunsetCalcuator
    var geoLocation: GeoLocation
    var workingDate: Date
    private var internalCalendar: Calendar
    
    init(location: GeoLocation) {
        self.geoLocation = location
        self.workingDate = Date()
        self.internalCalendar = Calendar(identifier: .gregorian)
        self.astronomicalCalculator = SunriseAndSunsetCalcuator(location: location)
    }
    
    /**
     *  This method calculates sunrise at the current geolocation.
     *
     *  The zenith used for the calculation uses geometric zenith of 90 degrees plus elevation.
     *  This is adjusted by the KCAstronomicalCalculator to add approximately 50/60 of a degree
     *  to account for 34 archminutes of refraction and 16 archminutes for the sun's radius for
     *  a total of 90.83333 degrees.
     *
     *  @see SunriseAndSunsetCalculator
     *  @return Sunrise as a Date.
     *  If the calculation cannot be computed, such as in the Arctic Circle, where there is
     *  at least one day a year that the sun does not rise, and one where it does not set,
     *  nil will be returned.
     */
    
    var sunrise: Date? {
        let sunrise = UTCSunrise(zenith: Constants.Zenith.geometric)
        if sunrise == nil { return nil }
        return dateFromTime(time: sunrise!)
    }
    
    /**
     *  This method calculates sunrise at sea-level at
     *  the latitude and longitude represented by the
     *  current geolocation.
     *
     *  Non-sunrise and sunset calculations such as dawn and dusk, depend on the amount of
     *  visible light, something that is not affected by elevation. This method returns
     *  sunrise calculated at sea level. This forms the base for dawn calculations that are
     *  calculated as a dip below the horizon before sunrise.
     *
     *  @return Sunrise at sea level as a Date.
     */
    var seaLevelSunrise: Date? {
        let sunrise = UTCSunrise(zenith: Constants.Zenith.geometric)
        if sunrise == nil { return nil }
        return dateFromTime(time: sunrise!)
    }
    
    /**
     *  This method returns the beginning of civil twilight (dawn) using a zenith of 96°.
     *
     *  @param offsetZenith The offset zenith.
     *
     * @return The Date of the beginning of civil twilight using a zenith of 96°. If the calculation
     *         can't be computed, nil will be returned. See detailed explanation on top of the page.
     */
    func sunriseOffsetByDegrees(offsetZenith: Double) -> Date? {
        let dawn = UTCSunrise(zenith: offsetZenith)
        if dawn == nil { return nil }
        return dateFromTime(time: dawn!)
    }
    
    /// Calculate the start of civil twilight.
    /// Will return `nil` in cases where the sun does not set.
    var beginCivilTwilight: Date? {
        return sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.civil)
    }
    
    /// Calculate the start of nautical twilight.
    /// Will return `nil` in cases where the sun does not set.
    var beginNauticalTwilight: Date? {
        return sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.nautical)
    }
    
    /// Calculate the start of astronomical twilight.
    /// Will return `nil` in cases where the sun does not set.
    var beginAstronomicalTwilight: Date? {
        return sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.astronomical)
    }
    
    /**
     *  This method returns an NSDate representing the time of sunset on
     *  the KCAstronomicalCalendar instance's workingDate property.
     *
     *  This method takes elevation into account.
     *
     *  @return A Date? representing sunset on workingDate, `nil`, if there is no sunset.
     */
    var sunset: Date? {
        let sunset = UTCSunset(zenith: Constants.Zenith.geometric)
        if sunset == nil { return nil }
        return adjustedSunsetDateWithSunset(
            sunset: dateFromTime(time: sunset!),
            sunrise: sunrise
        )
    }
    
    /**
     *  This method returns an NSDate representing the time of sunset on
     *  the KCAstronomicalCalendar instance's workingDate property.
     *
     *  This method does not take elevation into account.
     *
     *  @return A Date? representing sunset on workingDate, `nil`, if there is no sunset.
     */
    var seaLevelSunset: Date? {
        let sunset = UTCSeaLevelSunset(zenith: Constants.Zenith.geometric)
        if sunset == nil { return nil }
        return adjustedSunsetDateWithSunset(
            sunset: dateFromTime(time: sunset!),
            sunrise: sunrise
        )
    }
    
    /**
     * A utility method that returns the time of an offset by degrees below or above the horizon of {@link #getSunset()
     * sunset}. Note that the degree offset is from the vertical, so for a calculation of 14&deg; after sunset, an
     * offset of 14 + {@link #GEOMETRIC_ZENITH} = 104 would have to be passed as a parameter.
     *
     * @param offsetZenith the degrees after {@link #getSunset()} to use in the calculation.
     *          For time before sunset use negative numbers. Note that the degree offset is from the vertical, so for a calculation of 14&deg;
     *          after sunset, an offset of 14 + {@link #GEOMETRIC_ZENITH} = 104 would have to be passed as a parameter.
     * @return The {@link java.util.Date}of the offset after (or before) {@link #getSunset()}. If the calculation can't
     *         be computed such as in the Arctic Circle where there is at least one day a year where the sun does not
     *         rise, and one where it does not set, nil will be returned. See detailed explanation on top of the
     *         page.
     */
    func sunsetOffsetByDegrees(offsetZenith: Double) -> Date? {
        let sunset = UTCSunset(zenith: offsetZenith)
        if sunset == nil { return nil }
        return adjustedSunsetDateWithSunset(
            sunset: dateFromTime(time: sunset!),
            sunrise: sunrise
        )
    }
    
    func sunsetOffsetByDegrees(offsetZenith: Float) -> Date? {
        return sunsetOffsetByDegrees(offsetZenith: offsetZenith)
    }
    
    
    /**
     * A method that will roll the sunset time forward a day if sunset occurs before sunrise. This is a rare occurrence
     * and will typically happen when calculating very early and late twilights in a location with a time zone far off
     * from its natural 15&deg; boundaries. This method will ensure that in this case, the sunset will be incremented to
     * the following date. An example of this is Marquette, Michigan that far west of the natural boundaries for EST.
     * When you add in DST this pushes it an additional hour off. Calculating the extreme 26&deg;twilight on March 6th
     * it start at 2:34:30 on the 6th and end at 1:01:46 on the following day March 7th. Occurrences are more common in
     * the polar region for dips as low as 3&deg; (Tested for Hooper Bay, Alaska).
     *
     * @param sunset the sunset date to adjust if needed
     * @param sunrise the sunrise to compare to the sunset
     * @return the adjusted sunset date. If the calculation can't be computed such as in the Arctic Circle where there
     *         is at least one day a year where the sun does not rise, and one where it does not set, nil will be
     *         returned. See detailed explanation on top of the page.
     */
    func adjustedSunsetDateWithSunset(sunset: Date?, sunrise: Date?) -> Date? {
        if sunrise != nil &&
            sunset != nil &&
            sunrise!.timeIntervalSince(sunset!) > 0 {
            return internalCalendar.date(byAdding: .day, value: 1, to: sunset!)
        }
        return sunset
    }
    
    /**
     * A method that returns the end of civil twilight using a zenith of {@link #CIVIL_ZENITH 96&deg;}.
     *
     * @return The <code>Date</code> of the end of civil twilight using a zenith of {@link #CIVIL_ZENITH 96&deg;}. If
     *         the calculation can't be computed, nil will be returned. See detailed explanation on top of the page.
     */
    var endCivilTwilight: Date? {
        sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.civil)
    }
    
    /**
     * A method that returns the end of nautical twilight using a zenith of {@link #NAUTICAL_ZENITH 102&deg;}.
     *
     * @return The <code>Date</code> of the end of nautical twilight using a zenith of {@link #NAUTICAL_ZENITH 102&deg;}
     *         . If the calculation can't be computed, nil will be returned. See detailed explanation on top of the
     *         page.
     */
    var endNauticalTwilight: Date? {
        sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.nautical)
    }
    
    /**
     * A method that returns the end of astronomical twilight using a zenith of {@link #ASTRONOMICAL_ZENITH 108&deg;}.
     *
     * @return the <code>Date</code> of the end of astronomical twilight using a zenith of {@link #ASTRONOMICAL_ZENITH
     *         108&deg;}. If the calculation can't be computed, nil will be returned. See detailed explanation on top
     *         of the page.
     */
    var endAstronomicalTwilight: Date? {
        sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.astronomical)
    }
    
    /**
     * A method that returns the sunrise in UTC time without correction for time zone offset from GMT and without using
     * daylight savings time.
     *
     * @param zenith the degrees below the horizon. For time after sunrise use negative numbers.
     * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the calculation can't be computed such as in the
     *         Arctic Circle where there is at least one day a year where the sun does not rise, and one where it does
     *         not set, `nil` will be returned. See detailed explanation on top of the page.
     */
    func UTCSunrise(zenith: Double) -> Double? {
        astronomicalCalculator.UTCSunriseForDate(date: workingDate, zenith: zenith, adjustForElevation: true)
    }
    
    /**
     * A method that returns the sunrise in UTC time without correction for time zone offset from GMT and without using
     * daylight savings time. Non-sunrise and sunset calculations such as dawn and dusk, depend on the amount of visible
     * light, something that is not affected by elevation. This method returns UTC sunrise calculated at sea level. This
     * forms the base for dawn calculations that are calculated as a dip below the horizon before sunrise.
     *
     * @param zenith the degrees below the horizon. For time after sunrise use negative numbers.
     * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the calculation can't be computed such as in the
     *         Arctic Circle where there is at least one day a year where the sun does not rise, and one where it does
     *         not set, `nil` will be returned. See detailed explanation on top of the page.
     */
    func UTCSeaLevelSunrise(zenith: Double) -> Double? {
        return astronomicalCalculator.UTCSunriseForDate(date: workingDate, zenith: zenith, adjustForElevation: false)
    }
    
    /**
     * A method that returns the sunset in UTC time without correction for time zone offset from GMT and without using
     * daylight savings time.
     *
     * @param zenith the degrees below the horizon. For time after sunset use negative numbers.
     * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the calculation can't be computed such as in the
     *         Arctic Circle where there is at least one day a year where the sun does not rise, and one where it does
     *         not set, `nil` will be returned. See detailed explanation on top of the page.
     */
    func UTCSunset(zenith: Double) -> Double? {
        return astronomicalCalculator.UTCSunsetForDate(date: workingDate, zenith: zenith, adjustForElevation: true)
    }
    
    /**
     * A method that returns the sunset in UTC time without correction for elevation, time zone offset from GMT and
     * without using daylight savings time. Non-sunrise and sunset calculations such as dawn and dusk, depend on the
     * amount of visible light, something that is not affected by elevation. This method returns UTC sunset calculated
     * at sea level. This forms the base for dusk calculations that are calculated as a dip below the horizon after
     * sunset.
     *
     * @param zenith the degrees below the horizon. For time before sunset use negative numbers.
     * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the calculation can't be computed such as in the
     *         Arctic Circle where there is at least one day a year where the sun does not rise, and one where it does
     *         not set, `nil` will be returned. See detailed explanation on top of the page.
     */
    func UTCSeaLevelSunset(zenith: Double) -> Double? {
        return astronomicalCalculator.UTCSunsetForDate(date: workingDate, zenith: zenith, adjustForElevation: false)
    }
    
    /**
     * A utility method that will allow the calculation of a temporal (solar) hour based on the sunrise and sunset
     * passed as parameters to this method. An example of the use of this method would be the calculation of a
     * non-elevation adjusted temporal hour by passing in getSeaLevelSunrise sea level sunrise} and
     * {@link #getSeaLevelSunset() sea level sunset} as parameters.
     *
     * @param sunrise The start of the day.
     * @param sunset The end of the day.
     *
     * @return the long millisecond length of the temporal hour. If the calculation can't be computed,
     *         nil will be returned. See detailed explanation on top of the page.
     */
    func temporalHourFromSunrise(sunrise: Date?, sunset: Date?) -> Double? {
        guard sunrise != nil,
              sunset  != nil
        else {
            return nil
        }
        return sunset!.timeIntervalSince(sunrise!)/12
    }
    
    
    /**
     * A method that returns sundial or solar noon. It occurs when the Sun is
     * http://en.wikipedia.org/wiki/Transit_%28astronomy%29 transitting the
     * http://en.wikipedia.org/wiki/Meridian_%28astronomy%29" celestial meridian. In this class it is
     * calculated as halfway between sea level sunrise and sea level sunset, which can be slightly off the real transit
     * time due to changes in declination (the lengthening or shortening day).
     *
     * @return the <code>Date</code> representing Sun's transit. If the calculation can't be computed such as in the
     *         Arctic Circle where there is at least one day a year where the sun does not rise, and one where it does
     *         not set, nil will be returned. See detailed explanation on top of the page.
     */
    var sunTransit: Date? {
        return self.sunrise! + temporalHourFromSunrise(sunrise: sunrise, sunset: sunset)! * 6
    }
    
    
    /**
     *  Returns a formatted string representing the supplied
     *  date in the supplied time zone.
     *
     *  This method does not toggle the timezone of the
     *  NSDateFormatter that is used, so assume the default
     *  calendar.
     *
     *  @param date The date to display.
     *  @param timezone The time zone to format against.
     *  @param date The date representing the units larger than hours.
     *
     *  @return A string representation of the supplied date in the supplied time zone.
     */
    func dateFromTime(time: Double, timezone: TimeZone? = nil, onDate date: Date?=nil) -> Date {
        let timezone = timezone ?? TimeZone.current
        let date = date ?? workingDate
        
        var calculatedTime = time
        let gregorianCalendar = Calendar(identifier: .gregorian)
        var components: DateComponents = gregorianCalendar.dateComponents([
            .year, .month, .weekOfYear, .day,
            .hour, .minute, .second, .era
        ], from: date)
        
        components.timeZone = TimeZone(secondsFromGMT: 0)
        let hours = Int(calculatedTime)
        calculatedTime -= Double(hours)
        calculatedTime *= 60
        let minutes = Int(calculatedTime)
        calculatedTime -= Double(minutes)
        let seconds = Int(calculatedTime * 60)
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        
        var returnDate = gregorianCalendar.date(from: components)!
        
        let offsetFromGMT = Double(timezone.secondsFromGMT(for: date) / 3600)
        
        if time + offsetFromGMT > 24 {
            returnDate = internalCalendar.date(byAdding: .day, value: -1, to: returnDate)!
        } else if time + offsetFromGMT < 0 {
            returnDate = internalCalendar.date(byAdding: .day, value: 1, to: returnDate)!
        }
        
        return returnDate
    }
    
    func stringFromDate(_ date: Date, timezone: TimeZone, withSeconds: Bool=true) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = withSeconds ? .medium : .long
        formatter.timeZone = timezone
        return formatter.string(from: date)
    }
}

extension AstronomicalCalendar {
    func date(byAdding value: Int, component: Calendar.Component, to date: Date?) -> Date? {
        guard date != nil else { return nil }
        return self.internalCalendar.date(byAdding: component, value: value, to: date!)
    }
}

