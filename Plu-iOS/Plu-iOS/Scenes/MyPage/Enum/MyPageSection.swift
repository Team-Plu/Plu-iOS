//
//  MyPageSection.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

enum MyPageSection {
    case alarm(MyPageAlarmData)
    case info(MyPageInfomaitonType)
    case appVersion(MypageAppVersionData)
    case exit(MyPageUserExitType)
}

extension MyPageSection {
    static func makeMypageData(_ alarmAccept: Bool, _ appVersion: String?) -> [[Self]] {
        return [[.alarm(.init(.alarm, acceptAlarm: alarmAccept))],
                [.info(.faq),
                 .info(.openSource),
                 .info(.privacy)],
                [.appVersion(.init(.appVersion, appVersion: appVersion))],
                [.exit(.logout),
                 .exit(.resign)]]
    }
}
