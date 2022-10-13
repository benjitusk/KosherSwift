//
//  SunriseAndSunsetCalculator.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation

/// A class that uses the United States Naval Almanac Algorithm to calculate sunrise and sunset.
class SunriseAndSunsetCalcuator: AstronomicalCalculator {
    let calculatorName: String
    let geoLocation: GeoLocation
    init(location: GeoLocation?) {
        calculatorName = "United States Naval Almanac Algorithm"
        if location == nil {
            geoLocation = .Sample
        } else {
            geoLocation = location!
        }
    }
    
    func sunriseOrSunsetFor(date: Date, longitude: Double, latitude: Double, zenith: Double, type: Constants.SunCalculation) -> Double? {
        let dayOfYear = Calendar(identifier: .gregorian).ordinality(of: .day, in: .year, for: date)!
        let sunMeanAnomaly = meanAnomalyFor(dayOfYear: dayOfYear, longitude: longitude, forCalculation: type)
        let sunTrueLong = sunTrueLongitudeFromAnomaly(sunMeanAnomaly)
        let sunRightAscentionHours = sunRightAscensionHoursFor(sunTrueLongitude: sunTrueLong)
        let cosLocalHourAngle = cosLocalHourAngleFor(angle: sunTrueLong, latitude: latitude, zenith: zenith)
        var localHourAngle: Double = 0
        
        switch type {
        case .sunrise:
            if cosLocalHourAngle > 1 { return nil }
            localHourAngle = 360 - cosLocalHourAngle.acosDeg()
        case .sunset:
            if cosLocalHourAngle < -1 { return nil }
            localHourAngle = cosLocalHourAngle.acosDeg()
        }
        let localHour = localHourAngle / Double(Constants.degreesPerHour)
        let hoursFromMeridian = hoursFromMeridianFor(longitude: longitude)
        let approxTimeDays = approxTimeDaysFor(dayOfYear: dayOfYear, hoursFromMeridian: hoursFromMeridian, forCalculation: type)
        let localMeanTime = localMeanTimeFor(hour: localHour, ascension: sunRightAscentionHours, approxTimeDays: approxTimeDays)
        
        var processedTime = localMeanTime - hoursFromMeridian
        return processedTime.truncatingRemainder(dividingBy: 24)
    }
    
    func localMeanTimeFor(hour: Double, ascension: Double, approxTimeDays: Double) -> Double {
        return hour + ascension - (0.06571 * approxTimeDays) - 6.622
    }
    
    func cosLocalHourAngleFor(angle: Double, latitude: Double, zenith: Double) -> Double {
        let sinDec = 0.39782 * angle.sinDeg()
        let cosDec = sinDec.asinDeg().cosDeg()
        let cosH = zenith.cosDeg() - (sinDec * latitude.sinDeg()) / (cosDec * (latitude.cosDeg()))
        return cosH
    }
    
    func sunRightAscensionHoursFor(sunTrueLongitude longitude: Double) -> Double {
        let a = 0.91764 * longitude.tanDeg()
        var ra = 360.0 / (.pi * 2) * atan(a)
        
        // get result into 0-360 degree range
        // if (ra >= 360.0)ra = ra - 360.0;
        // if (ra < 0)ra = ra + 360.0;
        
        let lQuadrant = floor(longitude / 90.0) * 90.0;
        let raQuadrant = floor(ra / 90.0) * 90.0;
        ra = ra + (lQuadrant - raQuadrant);
        return ra / Double(Constants.degreesPerHour)
    }
    
    func sunTrueLongitudeFromAnomaly(_ sunMeanAnomaly: Double) -> Double {
        let trueLongitude = sunMeanAnomaly +
        (1.916 * sunMeanAnomaly.sinDeg()) +
        (0.020 * (2 * sunMeanAnomaly).sinDeg()) +
        282.634
        
        return trueLongitude.truncatingRemainder(dividingBy: 360)
    }
    
    func meanAnomalyFor(dayOfYear: Int, longitude: Double, forCalculation calculation: Constants.SunCalculation) -> Double {
        return (0.9856 * approxTimeDaysFor(dayOfYear: dayOfYear, hoursFromMeridian: hoursFromMeridianFor(longitude: longitude), forCalculation: calculation)) - 3.289
    }
    
    func hoursFromMeridianFor(longitude: Double) -> Double {
        return longitude/Double(Constants.degreesPerHour)
    }
    
    func approxTimeDaysFor(dayOfYear: Int, hoursFromMeridian: Double, forCalculation calculation: Constants.SunCalculation) -> Double {
        switch calculation {
        case .sunrise:
            return Double(dayOfYear) + (6.0 - hoursFromMeridian) / 24
        case .sunset:
            return Double(dayOfYear) + (18.0 - hoursFromMeridian) / 24
        }
    }
    
    func UTCSunsetForDate(date: Date, zenith: Double, adjustForElevation: Bool) -> Double? {
        return UTCSunriseOrSetForDate(date: date, zenith: zenith, adjustForElevation: adjustForElevation, type: .sunset)
    }
    
    func UTCSunriseForDate(date: Date, zenith: Double, adjustForElevation: Bool) -> Double? {
        return UTCSunriseOrSetForDate(date: date, zenith: zenith, adjustForElevation: adjustForElevation, type: .sunrise)
    }
    
    private func UTCSunriseOrSetForDate(date: Date, zenith: Double, adjustForElevation: Bool, type: Constants.SunCalculation) -> Double? {
        var zenith = zenith
        if adjustForElevation {
            zenith = adjustZenith(zenith, forElevation: geoLocation.altitude)
        } else {
            zenith = adjustZenith(zenith, forElevation: 0)
        }
        
        return sunriseOrSunsetFor(date: date,
                                        longitude: geoLocation.longitude,
                                        latitude: geoLocation.latitude,
                                        zenith: zenith,
                                        type: type)
    }
    
    func adjustZenith(_ zenith: Double, forElevation elevation: Double) -> Double {
        var zenith = zenith
        if zenith == Double(Constants.Zenith.geometric) {
            zenith += Double(Constants.solarRadius + Constants.refraction) + elevationAdjustment(elevation)
        }
        return zenith
    }
    
    func elevationAdjustment(_ elevation: Double) -> Double {
        let earthRadius = Double(Constants.earthRadiusInKilometers)
        return acos(earthRadius / (earthRadius + (elevation / 1000))).inDegrees
    }
}
