//
//  MyPageNavigation.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation
import Combine

protocol MyPageNavigation: AnyObject {
    var popUpCheckSubject: PassthroughSubject<Void, Never> { get set }
    func navigation(from type: MypageNavigationType)
}

