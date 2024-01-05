//
//  RegisterPopUpManager.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/26.
//

import Foundation

protocol RegisterPopUpManager {
    func resgisterAnswer() async throws
}

final class RegisterPopUpManagerImpl: RegisterPopUpManager {
    
    func resgisterAnswer() async throws {
        print("답변 등록에 성공했어요")
    }
}
