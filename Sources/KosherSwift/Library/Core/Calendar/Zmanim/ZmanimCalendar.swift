//
//  ZmanimCalendar.swift
//
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation

class ZmanimCalendar: AstronomicalCalendar {
    var alos72: Date?
    var alosHashachar: Date?
    var candleLighting: Date?
    /// I have no idea what the heck this is
    var candleLightingOffset = 0
    var chatzot: Date?
    var minchaGedola: Date?
    var minchaKetana: Date?
    var plagHamincha: Date?
    var shaahZmanisGra: Double?
    var shaahZmanisMogenAvraham: Double?
    var sofZmanShmaGra: Date?
    var sofZmanShmaMogenAvraham: Date?
    var sofZmanTfilaGra: Date?
    var sofZmanTfilaMogenAvraham: Date?
    var tzais: Date?
    var tzais72: Date?
    
    override init(location: GeoLocation) {
        super.init(location: location)
        alos72 = date(byAdding: -72, component: .minute, to: seaLevelSunrise)
        shaahZmanisGra = temporalHourFromSunrise(sunrise: seaLevelSunrise, sunset: seaLevelSunset)
        shaahZmanisMogenAvraham = temporalHourFromSunrise(sunrise: alos72, sunset: tzais72)
        alosHashachar = sunriseOffsetByDegrees(offsetZenith: Constants.Zenith.sixteenPointOne)
        chatzot = sunTransit
        if shaahZmanisGra != nil {
            sofZmanShmaGra  = seaLevelSunrise?.addingTimeInterval(shaahZmanisGra! * 3)
            sofZmanTfilaGra = seaLevelSunrise?.addingTimeInterval(shaahZmanisGra! * 4)
            minchaGedola    = seaLevelSunrise?.addingTimeInterval(shaahZmanisGra! * 6.5)
            minchaKetana    = seaLevelSunrise?.addingTimeInterval(shaahZmanisGra! * 9.5)
            plagHamincha    = seaLevelSunrise?.addingTimeInterval(shaahZmanisGra! * 10.75)
        } else {
            sofZmanShmaGra  = nil
            sofZmanTfilaGra = nil
            minchaGedola    = nil
            minchaKetana    = nil
            plagHamincha    = nil
        }
        if shaahZmanisMogenAvraham != nil {
            sofZmanShmaMogenAvraham     = seaLevelSunrise?.addingTimeInterval(shaahZmanisMogenAvraham! * 3)
            sofZmanTfilaMogenAvraham    = alos72?.addingTimeInterval(shaahZmanisMogenAvraham! * 4)
        } else {
            sofZmanShmaMogenAvraham     = nil
            sofZmanTfilaMogenAvraham    = nil
        }
        candleLighting = candleLightingWithOffsetFromSunset(offset: candleLightingOffset)
        tzais = sunsetOffsetByDegrees(offsetZenith: Constants.Zenith.eightPointFive)
        tzais72 = date(byAdding: 72, component: .minute, to: seaLevelSunset)
    }
    func candleLightingWithOffsetFromSunset(offset: Int) -> Date? {
        return date(byAdding: -offset, component: .minute, to: sunset)
    }
    
}
