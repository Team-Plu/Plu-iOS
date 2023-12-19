//
//  MyPageUserExitType.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

enum MyPageUserExitType {
    case logOut
    case resign
    
    var title: String {
        switch self {
        case .logOut:
            return StringConstant.MyPage.logOut.description
        case .resign:
            return StringConstant.MyPage.resign.description
        }
    }
    
    var changeToMyPageNavigation: MypageNavigationType {
        switch self {
        case .logOut:
            return .logout
        case .resign:
            return .resign
        }
    }
}
