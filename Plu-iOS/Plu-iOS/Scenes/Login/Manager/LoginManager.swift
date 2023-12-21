//
//  LoginManager.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation


protocol LoginManager {
    func login(type: LoginType, token: String) async throws
}
