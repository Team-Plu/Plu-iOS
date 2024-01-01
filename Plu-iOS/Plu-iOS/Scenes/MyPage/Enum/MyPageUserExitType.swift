//
//  MyPageUserExitType.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

enum MyPageUserExitType {
    case logout
    case resign
    
    var title: String {
        switch self {
        case .logout:
            return StringConstant.MyPage.logOut.description
        case .resign:
            return StringConstant.MyPage.resign.description
        }
    }
    
    var changeToMyPageNavigation: MypageNavigationType {
        switch self {
        case .logout:
            return .logout
        case .resign:
            return .resign
        }
    }
}
