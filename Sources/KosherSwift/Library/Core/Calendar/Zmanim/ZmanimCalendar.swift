//
//  ZmanimCalendar.swift
//  
//
//  Created by Benji Tusk on 10/12/22.
//

import Foundation

class ZmanimCalendar: ZmanimCalendarInterface {
    
}

protocol ZmanimCalendarInterface: AstronomicalCalendar {
    var candleLightingOffset: Int { get }
    var alosHashachar: Date { get }
    var alos72: Date { get }
    var chatzos: Date { get }
    var sofZmanShmaGra: Date { get }
    var sofZmanShmaMogenAvraham: Date { get }
    var candleLighting: Date { get }
    func candleLightingWithOffsetFromSunset(offset: Int) -> Date
    var candleLighting15: Date { get }
    var candleLighting18: Date { get }
    var candleLighting20: Date { get }
    var candleLighting22: Date { get }
    var candleLighting30: Date { get }
    var candleLighting40: Date { get }
    var sofZmanTfilaGra: Date { get }
    var sofZmanTfilaMogenAvraham: Date { get }
    var minchaGedola: Date { get }
    var minchaKetana: Date { get }
    var plagHamincha: Date { get }
    var tzais: Date { get }
    var tzais72: Date { get }
    var shaahZmanisGra: Double { get }
    var shaahZmanisMogenAvraham: Double { get }
}
