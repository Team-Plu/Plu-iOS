//
//  OnboardingManagerStub.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation

final class OnboardingManagerStub: NicknameManager {
    private let storedNicNames = ["의성", "민재", "찬미"]
    
    func judgeInputNicknameVaild(input: String) async throws -> Bool {
        return !storedNicNames.contains(input)
    }
}
