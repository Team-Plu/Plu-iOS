//
//  OnboardingManager.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation

protocol OnboardingManager {
    func judgeInputNicknameVaild(input: String) async throws -> Bool
}
