//
//  OnboardingManagerStub.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation

enum OnboardingError: Error {
    case nickNameUnValid
}

final class NicknameManagerStub: NicknameManager {

    var userNickName: String? {
        didSet {
            guard let userNickName else { return }
            print("\(userNickName)이 등록되었습니다")
        }
    }
    
    private let storedNicNames = ["의성", "민재", "찬미"]
    
    func inputNicknameIsVaild(input: String) async throws -> Bool {
        return !storedNicNames.contains(input)
    }
    
    func changeNickName(newNickname: String?) async throws {
        guard let newNickname else { return }
        userNickName = newNickname
        print("닉네임변경이 완료되었습니다")
    }
    
    func registerUser(nickName: String?) async throws {
        self.userNickName = nickName
    }
    
    func getUserNickName() async throws -> String {
        guard let userNickName else {
            throw OnboardingError.nickNameUnValid
        }
        return userNickName
    }
}
