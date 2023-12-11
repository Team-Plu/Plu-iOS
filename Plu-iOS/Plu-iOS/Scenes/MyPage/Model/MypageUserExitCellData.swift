//
//  MypageUserExitCellData.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import Foundation

struct MypageUserExitCellData: MyPageCell {
    var title: String
    
    init(_ type: StringConstant.MyPage) {
        self.title = type.description
    }
}
