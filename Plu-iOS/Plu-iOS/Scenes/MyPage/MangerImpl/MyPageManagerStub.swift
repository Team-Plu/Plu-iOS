//
//  MyPageManagerStub.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation

final class MyPageManagerStub: MyPageManager {
    func getUserData() async throws -> MyPageUserData {
        return .dummyData
    }
}
