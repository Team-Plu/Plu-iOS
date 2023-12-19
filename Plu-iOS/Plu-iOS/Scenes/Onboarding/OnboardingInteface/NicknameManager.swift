//
//  OnboardingManager.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation

protocol NicknameManager {
    func inputNicknameIsVaild(input: String) async throws -> Bool
    func changeNickName(newNickname: String?) async throws
    func registerUser(nickName: String?) async throws
    func getUserNickName() async throws -> String
}
