//
//  MyPageNavigation.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation

protocol MyPageNavigation {
    var delegate: MyPageAdaptorDelegate? { get set }
    func navigation(from type: MypageNavigationType)
//    func backButtonTapped()
//    func myPageHeaderTapped()
//    func resignCellTapped()
//    func logoutCellTapped()
//    func alarmSwitchOff()
//    func faqCellTapped()
//    func openSourceCellTapped()
//    func privacyCellTapped()
}

