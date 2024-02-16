//
//  MyPageNavigation.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation



protocol MyPageNavigation: AnyObject {
    var delegate: MyPageDelegate? { get set }
    func navigation(from type: MypageNavigationType)
}

