//
//  File.swift
//  
//
//  Created by Benji Tusk on 10/7/22.
//

import Foundation
extension Constants {
    enum ParshaIdentifier: Int {
        case parashaBereshit = 0
        case parashaNoach
        case parashaLechLecha
        case parashaVayeira
        case parashaChayeiSarah
        case parashaToldot
        case parashaVayeitsei
        case parashaVayishlach
        case parashaVayeishev
        case parashaMiketz
        case parashaVayigash
        case parashaVayechi
        case parashaShemot
        case parashaVaera
        case parashaBo
        case parashaBeshalach
        case parashaYitro
        case parashaMishpatim
        case parashaTerumah
        case parashaTetzaveh
        case parashaTerumahAndTetzaveh    //  Terumah - Tetzaveh
        case parashaKiTissa
        case parashaVayakhel
        case parashaPekudei
        case parashaVayakhelAndPekudei    //  Vayakhel - Pekudei
        case parashaVayikra
        case parashaTzav
        case parashaShemini
        case parashaTazria
        case parashaMetzora
        case parashaTazriaAndMetzora
        case parashaAchareiMot
        case parashaKedoshim
        case parashaAchareiMotAndKedoshim //  Acharei - Kedoshim
        case parashaEmor
        case parashaBehar
        case parashaBechukotai
        case parashaBeharAndBechukotai    //  Behar - Bechukotai
        case parashaBamidbar
        case parashaNaso
        case parashaBehaalotecha
        case parashaShelach
        case parashaKorach
        case parashaChukat
        case parashaBalak
        case parashaChukatAndBalak        //  Chukat - Balak
        case parashaPinchas
        case parashaMatot
        case parashaMasei
        case parashaMatotAndMasei         //  Matot - Masei
        case parashaDevarim
        case parashaVaetchanan
        case parashaEikev
        case parashaReeh
        case parashaShoftim
        case parashaKiTeitzei
        case parashaKiTavo
        case parashaNitzavim
        case parashaVayeilech
        case parashaNitzavimAndVayeilech  //  Nitzavim - Vayeilech
        case parashaHaazinu
        case parashaVezotHaberacha
        case parashaRoshHashana1  //  Rosh Hashana falls on Shabbat
        case parashaYomKippur     //  Yom Kippur falls on Shabbat
        case parashaSukkot1       //  Sukkot falls on Shabbat
        case parashaSukkot3       //  Chol Hamoed Sukkot falls on Shabbat
        case parashaSheminiAtzeret//  Shemini Atzeret falls on Shabbat
        case parashaPesach1       //  The first night of pesach falls on Shabbat
        case parashaPesach3       //  Chol Hamoed Pesach contains a Shabbat
        case parashaPesach7       //  The 7th day of Pesach falls on Shabbat
        case parashaPesach8       //  In diaspora, the 8th day of Pesach falls on Shabbat
        case parashaShavuot2      //  The second day of Shavuot falls on Shabbat

    }
}
