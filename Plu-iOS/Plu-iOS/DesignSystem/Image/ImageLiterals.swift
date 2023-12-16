//
//  ImageLiterals.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/3/23.
//

import UIKit

enum ImageLiterals {
    
    enum PopUp {
        static var alarm: UIImage { .load(named: "ic_alarm") }
    }
    
    enum Splash {
        static var pluWordmarkLarge: UIImage { .load(named: "plu_wordmark_large") }
        static var dustEye: UIImage { .load(named: "ic_eyes_dust") }
        static var fireEye: UIImage { .load(named: "ic_eyes_fire") }
        static var waterEye: UIImage { .load(named: "ic_eyes_water") }
        static var airEye: UIImage { .load(named: "ic_eyes_air") }
    }
    
    enum Tutorial {
        static var characterSet: UIImage { .load(named: "ic_character_set") }
        static var screenshot1: UIImage { .load(named: "screenshot1") }
        static var screenshot2: UIImage { .load(named: "screenshot2") }
        static var screenshot3: UIImage { .load(named: "screenshot3") }
        static var kakaoLogo: UIImage { .load(named: "ic_kakao") }
        static var AppleLogo: UIImage { .load(named: "ic_apple") }
    }
    
    enum Onboarding {
        static var eraseButton: UIImage { .load(named: "btn_erase") }
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
        static var arrowLeft: UIImage { .load(named: "ic_arrow_left") }
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
        
        static var arrowDownSmall600: UIImage { .load(named: "ic_arrow_down_small_600") }
        static var arrowUpSmall600: UIImage { .load(named: "ic_arrow_up_small_600") }
        static var arrowDownLarge600: UIImage { .load(named: "ic_arrow_down_large_600") }
    }
    
    enum MyPage {
        static var profile60: UIImage { .load(named: "ic_profile_60") }
        static var profile92: UIImage { .load(named: "ic_profile_92") }
        static var farewellCharacter: UIImage { .load(named: "ic_air") }
        static var arrowRightSmall500: UIImage { .load(named: "ic_arrow_right_small_500") }
        static var arrowRightSmall900: UIImage { .load(named: "ic_arrow_right_small_900") }
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
