//
//  MyPageSection.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

enum MyPageSection {
    case alarm(MyPageAlarmCellData)
    case info(MypageInfomationCellData)
    case appVersion(MypageAppVersionCellData)
    case exit(MypageUserExitCellData)
}

extension MyPageSection {
    static func makeMypageData(_ alarmAccept: Bool, _ appVersion: String?) -> [[Self]] {
        return [[.alarm(.init(.alarm, acceptAlarm: alarmAccept))],
                [.info(.init(.faq)),
                 .info(.init(.openSource)),
                 .info(.init(.privacy))],
                [.appVersion(.init(.appVersion, appVersion: appVersion))],
                [.exit(.init(.logOut)),
                 .exit(.init(.resign))]]
    }
}
