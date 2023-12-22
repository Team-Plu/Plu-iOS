//
//  NicknameEditInput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/21.
//

import Foundation
import Combine

struct NicknameEditInput {
    let textFieldSubject: AnyPublisher<String, Never>
    let naviagtionLeftButtonTapped: PassthroughSubject<Void, Never>
    let naviagtionRightButtonTapped: PassthroughSubject<String?, Never>
}
