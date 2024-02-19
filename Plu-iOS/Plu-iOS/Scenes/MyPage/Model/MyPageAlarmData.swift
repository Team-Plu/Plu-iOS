//
//  MyPageAlarmCellData.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

struct MyPageAlarmData {
    var title: String
    let acceptAlarm: Bool
    
    init(_ type: StringConstant.MyPage, acceptAlarm: Bool) {
        self.title = type.description
        self.acceptAlarm = acceptAlarm
    }
}
