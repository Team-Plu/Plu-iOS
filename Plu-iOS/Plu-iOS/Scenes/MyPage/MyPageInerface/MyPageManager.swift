//
//  MyPageManager.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation

protocol MyPageManager {
    func getUserData() async throws -> MyPageUserData
}
