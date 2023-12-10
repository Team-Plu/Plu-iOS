//
//  MypageInfomationCellData.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

struct MypageInfomationCellData: MyPageCell {
    var title: String
    
    init(_ type: StringConstant.MyPage) {
        self.title = type.description
    }
}
