//
//  NicknameState.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation

struct NicknameState {
    let errorDescription: String?
    let nextProcessButtonIsActive: Bool?
    
    init(type: StringConstant.Nickname, isActive: Bool?) {
        self.errorDescription = type.description
        self.nextProcessButtonIsActive = isActive
    }
}

extension NicknameState {
    
    static func textFieldOver() -> Self {
        return .init(type: .textFieldOver, isActive: false)
    }
    
    static func textFieldEmpty() -> Self {
        return .init(type: .textFieldEmpty, isActive: false)
    }
    
    static func textFieldError() -> Self {
        return .init(type: .textFieldError, isActive: false)
    }
    
    static func nickNameNonValid() -> Self {
        return .init(type: .nickNameNonValid, isActive: false)
    }
    
    static func none() -> Self {
        return .init(type: .none, isActive: nil)
    }
    
    static func nickNameValid() -> Self {
        return .init(type: .nickNameValid, isActive: true)
    }
}
