//
//  MypageAppVersionCellData.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

struct MypageAppVersionData: MyPageCell {
    var title: String
    let appVersion: String?
    
    init(_ type: StringConstant.MyPage, appVersion: String?) {
        self.title = type.description
        self.appVersion = appVersion
    }
}
