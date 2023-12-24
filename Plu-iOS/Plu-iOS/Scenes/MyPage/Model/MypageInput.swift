//
//  MypageInput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation
import Combine

struct MypageInput {
    var navigationSubject: PassthroughSubject<MypageNavigationType, Never>
    var viewWillAppearSubject: PassthroughSubject<Void, Never>
}
