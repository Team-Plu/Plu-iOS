//
//  MyPageInfomaitonType.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

enum MyPageInfomaitonType {
    case faq
    case openSource
    case privacy
    
    var title: String {
        switch self {
        case .faq:
            return StringConstant.MyPage.faq.description
        case .openSource:
            return StringConstant.MyPage.openSource.description
        case .privacy:
            return StringConstant.MyPage.privacy.description
        }
    }
    
    var changeToMyPageNavigation: MypageNavigationType {
        switch self {
        case .faq:
            return .faq
        case .openSource:
            return .openSource
        case .privacy:
            return .privacy
        }
    }
}

