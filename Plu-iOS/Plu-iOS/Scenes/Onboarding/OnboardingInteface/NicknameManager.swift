//
//  OnboardingManager.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation

protocol NicknameManager {
    func inputNicknameIsVaild(input: String) async throws -> Bool
}
