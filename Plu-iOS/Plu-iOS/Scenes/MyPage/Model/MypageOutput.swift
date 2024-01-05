//
//  MypageOutput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation
import Combine

struct MypageOutput {
    var viewWillAppearPublisher: AnyPublisher<MyPageUserData, Never>
    var switchOnSubject: PassthroughSubject<Void, Never>
}
