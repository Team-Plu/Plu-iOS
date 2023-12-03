//
//  Font.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/03.
//

import UIKit

public enum Font {
    
    public enum SuiteType {
        case head1, head2, head3, subHead1, title1, title2, body1M, body1R, body2M, body2R, body3, body4B, caption
        
        var weight: Font.Weight {
            switch self {
            case .body4B: return ._700
            case .head1, .head2, .head3, .title1, .title2: return ._600
            case .subHead1, .body1M, .body2M, .caption: return ._500
            case .body1R, .body2R, .body3: return ._400
            }
        }
        
        var size: CGFloat {
            switch self {
            case .caption: return Font.Size._8.rawValue
            case .body4B: return Font.Size._10.rawValue
            case .body3: return Font.Size._12.rawValue
            case .body2R, .body2M, .title2: return Font.Size._14.rawValue
            case .body1R, .body1M, .title1, .subHead1: return Font.Size._16.rawValue
            case .head3: return Font.Size._18.rawValue
            case .head2: return Font.Size._20.rawValue
            case .head1: return Font.Size._24.rawValue
            }
        }
    }
    
    public enum Name: String {
        case suite = "SUITE"
    }
    
    public enum Size: CGFloat {
        case _8 = 8
        case _10 = 10
        case _12 = 12
        case _14 = 14
        case _16 = 16
        case _18 = 18
        case _20 = 20
        case _24 = 24
    }

    public enum Weight: String {
        case _400 = "Regular"
        case _500 = "Medium"
        case _600 = "SemiBold"
        case _700 = "Bold"

        var real: UIFont.Weight {
            switch self {
            case ._400:
                return .regular
            case ._500:
                return .medium
            case ._600:
                return .semibold
            case ._700:
                return .bold
            }
        }
    }

    public struct SuiteFont {
        private let _name: Name
        private let _weight: Weight

        init(name: Name, weight: Weight) {
            self._name = name
            self._weight = weight
        }

        var name: String {
            "\(_name.rawValue)-\(_weight.rawValue)"
        }

        var `extension`: String {
            "ttf"
        }
    }
    

    public static func registerFonts() {
        pretendardFonts.forEach { font in
            Font.registerFont(fontName: font.name, fontExtension: font.extension)
        }
    }
}

extension Font {
    static var pretendardFonts: [SuiteFont] {
        [
            SuiteFont(name: .suite, weight: ._400),
            SuiteFont(name: .suite, weight: ._500),
            SuiteFont(name: .suite, weight: ._600),
            SuiteFont(name: .suite, weight: ._700)
        ]
    }

   static func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = Bundle(identifier: "uikit.Plu-iOS")?.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            debugPrint("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            return
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}


