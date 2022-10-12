//
//  Zman.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
class Zman {
    
}

protocol ZmanInterface: Equatable {
    var hebrewName: String { get }
    var shortHebrewaName: String { get }
    var transliteratedNameAshkenazic: String { get }
    var transliteratedNameSephardic: String { get }
    var englishName: String { get }
    var shortEnglishName: String { get }
    func nameFromDisplayName(displayName: String) -> String
    func rabbinicOpinionFromDisplayName(displayName: String) -> String
    var explanation: String { get }
    var relatedZmanim: [Zman]  { get }
    static var relatedZmanimMapping: [[String]] { get }
    static var metadata: [String: [String: String]] { get }
}
