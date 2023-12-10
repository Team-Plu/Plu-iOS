//
//  NicknameState.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation

struct NicknameState {
    let errorDescription: String?
    let nextProcessButtonIsActive: Bool
}

extension NicknameState {
    init(_ type: StringConstant.Nickname) {
        self.init(errorDescription: type.description, nextProcessButtonIsActive: type == .nickNameValid ? true : false)
    }
}
