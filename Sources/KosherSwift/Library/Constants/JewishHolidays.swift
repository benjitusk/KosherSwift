//
//  File.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants {
    /** kYomimTovim
     *
     *  Jewish holidays (and their "eve"s), including:
     *
     *  The three primary holidays:
     *  - Pesach
     *  - Shavuot
     *  - Sukkot
     *
     *  Secondary or rabinically instituted holidays:
     *
     *  - Purim, Shushan Purim, and Purim Katan
     *  - Chanukah
     *  - Rosh Chodesh (The new moon)
     *
     *  Fast Days
     *  - Yom Kippur
     *  - Seventeenth of Tammuz
     *  - Ninth of Av
     *  - Fast of Gedalya
     *  - Tenth of Tevet
     *  - Fast of Esther
     *
     *  Zionist Holidays
     *  - Yom Hashoah (Holocaust Memorial Day)
     *  - Yom Hazikaron (Memorial Day)
     *  - Yom Haatzmaut (Independence Day)
     *  - Yom Yerushalayim (Jerusalem Day)
     *
     *  Take a look at the enum for the ones that aren't included.
     */
    enum YomimTovim: Int {
        case erevPesach = 0
        case pesach
        case cholHamoedPesach
        case pesachSheni
        case erevShavuos
        case shavuos
        case seventeenthOfTammuz
        case ninthOfAv
        case tuBeav
        case erevRoshHashana
        case roshHashana
        case fastOfGedalya
        case erevYomKippur
        case yomKippur
        case erevSuccos
        case succos
        case cholHamoedSuccos
        case hoshanaRabba
        case sheminiAtzeres
        case simchasTorah
        case erevChanukah
        case chanukah
        case tenthOfTevet
        case tuBeshvat
        case fastOfEsther
        case purim
        case shushanPurim
        case purimKatan
        case roshChodesh
        case yomHashoah
        case yomHazikaron
        case yomHaatzmaut
        case yomYerushalayim
    }
}
