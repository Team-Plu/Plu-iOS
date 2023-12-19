//
//  PopUpCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation

enum AlarmType {
    case todayQuestion, mypage
}

@frozen
enum PopUpType {
    case alarm(AlarmType)
    case register
    case selectMonth(year: Int, month: Int)
}

protocol PopUpCoordinator: Coordinator {
    func show(type: PopUpType)
    func accept(type: PopUpType)
    func dismiss()
}

