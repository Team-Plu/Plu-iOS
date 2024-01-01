//
//  MyPageManagerStub.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation

final class MyPageManagerStub: MyPageManager {
    func logout() async throws {
        print("로그아웃했습니다")
    }
    
    func getUserData() async throws -> MyPageUserData {
        return .dummyData
    }
}
