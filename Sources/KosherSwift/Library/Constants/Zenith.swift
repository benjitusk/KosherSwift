//
//  File.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants {
    /**
     * A collection of all constant values related to calculating the zenith
     */
    struct Zenith {
        
        /** kZenithGeometric
         *
         *  The zenith of astronomical sunrise and sunset.
         *  The sun is 90 degrees from the vertical 0 degrees.
         *  It is important to note that for sunrise and sunset the adjusted zenith is required to account for the radius of the sun and refraction. The adjusted zenith should not
         * be used for calculations above or below 90 degrees since they are usually are calculated as an offset to 90 degrees.
         */
        static let geometric: Float = 90.0
        
        /** kZenithCivil
         *
         *  The sun's zenith at civil twilight (96 degrees)
         */
        static let civil: Float = 96.0
        
        /** kZenithNautical
         *
         *  The sun's zenith at nautical twilight (102 degrees)
         */
        static let nautical: Float = 102.0
        
        /** kZenithAstronomical
         *
         *  The sun's zenith at astronomical twilight (108 degrees)
         */
        static let astronomical: Float = 108.0
    }
}
