//
//  MypageInput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation
import Combine

struct MypageInput {
    let headerTapped: PassthroughSubject<MypageNavigationType, Never>
    let faqCellTapped: PassthroughSubject<MypageNavigationType, Never>
    let backButtonTapped: PassthroughSubject<MypageNavigationType, Never>
    let resignCellTapped: PassthroughSubject<MypageNavigationType, Never>
    let logoutCellTapped: PassthroughSubject<Void, Never>
    let alarmSwitchTapped: PassthroughSubject<MypageNavigationType, Never>
    let openSourceCellTapped: PassthroughSubject<MypageNavigationType, Never>
    let privacyCellTapped: PassthroughSubject<MypageNavigationType, Never>
    var viewWillAppearSubject: PassthroughSubject<Void, Never>
}
