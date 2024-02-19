//
//  ResignPopUpManager.swift
//  Plu-iOS
//
//  Created by uiskim on 2/19/24.
//

import Foundation

protocol ResignPopUpManager {
    func resign() async throws
}

final class ResignPopUpManagerImpl: ResignManager {
    func resign() async throws {
        print("회원탈퇴")
    }
}
