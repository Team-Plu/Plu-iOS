//
//  MyPageUserData.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

struct MyPageUserData {
    let nickName: String
    let acceptAlarm: Bool
    let appVersion: String
}

extension MyPageUserData {
    static let dummyData: Self = .init(nickName: "Plu님", acceptAlarm: false, appVersion: "1.0.0")
}

extension MyPageUserData {
    static let errorDummy: Self = .init(nickName: "오류발생", acceptAlarm: false, appVersion: "error")
}
