//
//  ImageLiterals.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/3/23.
//

import UIKit

enum ImageLiterals {
    enum Splash {
        static var pluWordmarkLarge: UIImage { .load(named: "plu_wordmark_large") }
    }
    
    enum Tutorial {
        static var characterSet: UIImage { .load(named: "ic_character_set") }
        static var kakaoLogo: UIImage { .load(named: "ic_kakao") }
        static var AppleLogo: UIImage { .load(named: "ic_apple") }
    }
    
    enum OnboardingCompleted {
        static var alarm: UIImage { .load(named: "ic_alarm") }
    }
    
    enum Main {
        static var waterTodayQuestion: UIImage { .load(named: "ic_today_question_water") }
        static var dustTodayQuestion: UIImage { .load(named: "ic_today_question_dust") }
        static var airTodayQuestion: UIImage { .load(named: "ic_today_question_air") }
        static var fireTodayQuestion: UIImage { .load(named: "ic_today_question_fire") }
        static var seeYouTommorowSpeechBubble: UIImage { .load(named: "ic_speechbubble_large") }
    }
    
    enum NavigationBar {
        static var profile32: UIImage { .load(named: "ic_profile_32") }
    }
    
    enum TabBar {
        static var homeActivated: UIImage { .load(named: "ic_home_activated") }
        static var homeInActivated: UIImage { .load(named: "ic_home_inactivated") }
        static var recordActivated: UIImage { .load(named: "ic_record_activated") }
        static var recordInActivated: UIImage { .load(named: "ic_record_inactivated") }
    }

    enum Respone {
        static var airEmpathySmall: UIImage { .load(named: "ic_empathy_small_air") }
        static var fireEmpathySmall: UIImage { .load(named: "ic_empathy_small_fire") }
        static var waterEmpathySmall: UIImage { .load(named: "ic_empathy_small_water") }
        static var dustEmpathySmall: UIImage { .load(named: "ic_empathy_small_dust") }
        
        static var airCharacterSmall: UIImage { .load(named: "ic_air_small") }
        static var fireCharacterSmall: UIImage { .load(named: "ic_fire_small") }
        static var waterCharacterSmall: UIImage { .load(named: "ic_water_small") }
        static var dustCharacterSmall: UIImage { .load(named: "ic_dust_small") }
    }
    
    enum MyPage {
        static var profile60: UIImage { .load(named: "ic_profile_60") }
        static var profile92: UIImage { .load(named: "ic_profile_92") }
        static var farewellCharacter: UIImage { .load(named: "ic_air") }
    }
}


extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
}
