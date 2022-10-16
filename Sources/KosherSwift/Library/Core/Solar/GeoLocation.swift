//
//  GeoLocation.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
class GeoLocation {
    let loationName: String
    var latitude: Double
    var longitude: Double
    let timeZone: TimeZone
    let altitude: Double
    
    
    /**
     *  This method insantiates a new KCGeoLocation.
     *
     *  @param name A name for the location. This isn't required.
     *  @param latitude The latitude that the location represents.
     *  @param longitude The longitude that the location represents.
     *  @param timezone The time zone that the location represents.
     *  @param elevation The altitude that the location represents.
     *
     *  @return A configured KCGeoLocation instance.
     */
    init(name: String="Unspecified Location", latituide: Double, longitude: Double, elevation: Double=0, timeZone: TimeZone) {
        self.loationName = name
        self.latitude = latituide
        self.longitude = longitude
        self.timeZone = timeZone
        self.altitude = elevation
    }
    
    static let sample = GeoLocation(name: "Greenwich, England",
                                    latituide: 51.4772,
                                    longitude: 0,
                                    timeZone: TimeZone(secondsFromGMT: 0)!
    )
    
    enum Direction {
        case North
        case East
        case West
        case South
    }
    
    func setLatitudeWith(degrees: Double, minutes: Double, seconds: Double, direction: Direction) {
        var lat = degrees + minutes + (seconds / 60.0) / 60.0
        guard lat >= 0 && lat <= 90 else {
            print("WARNING: \(lat) must be between 0 and 90. Use .South instead of negative values.")
            return
        }
        
        if direction == .South {
            lat *= -1
        } else if direction != .North {
            print("WARNING: `direction` must be .North or .South.")
            return
        }
        self.latitude = lat
    }
    
    func setLongitudeWith(degrees: Double, minutes: Double, seconds: Double, direction: Direction) {
        var lon = degrees + minutes + (seconds / 60.0) / 60.0
        guard lon >= 0 && lon <= 180 else {
            print("WARNING: \(lon) must be between 0 and 180. Use .West instead of negative values.")
            return
        }
        
        if direction == .West {
            lon *= -1
        } else if direction != .East {
            print("WARNING: `direction` must be .East or .West.")
            return
        }
        self.longitude = lon
    }

    var localMeanTimeOffset: Int {
        Int(self.longitude) * 4 * 60 * 1000 - (self.timeZone.secondsFromGMT() * 1000)
    }
    
    func vincentyFormulaFor(location: GeoLocation, withBearing formula: Constants.BearingFormula) -> Double? {
        let a: Double = 6378137
        let b: Double = 6356752.3142
        let f: Double = 1 / 298.257223563  // WGS-84 ellipsio
        let L: Double = (location.longitude - self.longitude).inRadians
        let U1: Double = atan((1 - f) * tan(self.latitude.inRadians))
        let U2: Double = atan((1 - f) * tan(location.latitude.inRadians))
        let sinU1: Double = sin(U1), cosU1 = cos(U1)
        let sinU2: Double = sin(U2), cosU2 = cos(U2)
        
        var lambda: Double = L
        var lambdaP: Double = 2 * .pi
        var iterLimit: Double = 20
        var sinLambda: Double = 0
        var cosLambda: Double = 0
        var sinSigma: Double = 0
        var cosSigma: Double = 0
        var sigma: Double = 0
        var sinAlpha: Double = 0
        var cosSqAlpha: Double = 0
        var cos2SigmaM: Double = 0
        var C: Double

        while (fabs(lambda - lambdaP) > 1e-12 && {iterLimit -= 1; return iterLimit}() > 0) {
            sinLambda = sin(lambda)
            cosLambda = cos(lambda)
            sinSigma = sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda)
                            + (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda)
                            * (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda))
            if sinSigma == 0 {
                return 0 // co-incident points
            }
            cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda
            sigma = atan2(sinSigma, cosSigma)
            sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma
            cosSqAlpha = 1 - sinAlpha * sinAlpha
            cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha
            //Check if this is correct
            if cos2SigmaM.isNaN {
                cos2SigmaM = 0 // equatorial line: cosSqAlpha=0 (ß6)
            }
            C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha))
            lambdaP = lambda
            lambda = L
            + (1 - C)
            * f
            * sinAlpha
            * (sigma + C
               * sinSigma
               * (cos2SigmaM + C * cosSigma
                  * (-1 + 2 * cos2SigmaM * cos2SigmaM)
                 )
            )
        }
        
        if iterLimit == 0 {
            return nil; // formula failed to converge
        }
        
        let uSq: Double = cosSqAlpha * (a * a - b * b) / (b * b);
        let A: Double = 1 + uSq / 16384
        * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
        let B: Double = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
        let deltaSigma: Double = B
        * sinSigma
        * (cos2SigmaM + B
           / 4
           * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B
              / 6 * cos2SigmaM
              * (-3 + 4 * sinSigma * sinSigma)
              * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
        let distance: Double = b * A * (sigma - deltaSigma);
        
        // initial bearing
        let fwdAz: Double = atan2(cosU2 * sinLambda, cosU1 * sinU2 - sinU1 * cosU2 * cosLambda).inDegrees
        // final bearing
        let revAz: Double = atan2(cosU1 * sinLambda, -sinU1 * cosU2 + cosU1 * sinU2 * cosLambda).inDegrees
        switch formula {
        case .distance:
            return distance
        case .initialBearing:
            return fwdAz
        case .finalBearing:
            return revAz
        }

    }
    
    func getRhumbLineBearingFor(location: GeoLocation) -> Double {
        let dLon = (location.longitude - self.longitude).inRadians
        let dPhi = log(
            tan(location.latitude.inRadians / 2 + .pi / 4) /
            tan(self.latitude.inRadians / 2 + .pi / 4)
        )
        return atan2(dLon, dPhi).inDegrees
    }
    
    func getRhumbLineDistanceFor(location: GeoLocation) -> Double {
        let R: Double = 6371;  // earth's mean radius in km
        let dLat: Double = (location.latitude - self.latitude).inRadians;
        var dLon: Double = fabs(location.longitude - self.longitude).inRadians;
        let dPhi: Double = log(tan(location.longitude.inRadians / 2 + .pi / 4) /
                               tan(self.latitude.inRadians / 2 + .pi / 4));
        let q: Double = (fabs(dLat) > 1e-10) ? dLat / dPhi : cos(self.latitude.inRadians);
        // if dLon over 180° take shorter rhumb across 180° meridian:
        if dLon > .pi {
            dLon = 2 * .pi - dLon;
        }
        let d = sqrt(dLat * dLat + q * q * dLon * dLon);
        
        return d * R;
    }

    var description: String {
        return "<GeoLocation:> ----\nName: \(self.loationName) \nLatitude: \(latitude), \nLongitude: \(longitude) \nAltitude: \(altitude)"
    }
    
}
