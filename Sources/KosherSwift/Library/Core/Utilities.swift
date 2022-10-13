//
//  Utilities.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Double {
    
    var inRadians: Double {
        (self * .pi) / 180.0
    }
    
    var inDegrees: Double {
        (self * 180.0) / .pi
    }
    
    func sinDeg() -> Double {
        sin(self * 2.0 * .pi / 360.0)
    }
    
    func acosDeg() -> Double {
        acos(self) * 360.0 / (2 * .pi);
    }
    
    func asinDeg() -> Double {
        asin(self) * 360.0 / (2 * .pi)
    }
    
    func tanDeg() -> Double {
        tan(self * 2.0 * .pi / 360.0)
    }
    
    func cosDeg() -> Double {
        cos(self * 2.0 * .pi / 360.0)
    }
}
