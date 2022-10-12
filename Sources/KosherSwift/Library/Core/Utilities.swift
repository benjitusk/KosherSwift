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
    
    var sinOf: Double {
        sin(self * 2.0 * .pi / 360.0)
    }
    
    var acosOf: Double {
        acos(self) * 360.0 / (2 * .pi);
    }
    
    var asinOf: Double {
        asin(self) * 360.0 / (2 * .pi)
    }
    
    var tanOf: Double {
        tan(self * 2.0 * .pi / 360.0)
    }
    
    var cosOf: Double {
        cos(self * 2.0 * .pi / 360.0)
    }
}
