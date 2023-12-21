//
//  NicknameEditOutput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/21.
//

import Foundation
import Combine

struct NicknameEditOutput {
    let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    let loadingViewSubject: AnyPublisher<LoadingState, Never>
}
