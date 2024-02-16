//
//  MyPageNavigation.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation

protocol MyPageNavigation: AnyObject {
    //TODO: 수정필요
//    var delegate: MyPageAdaptorDelegate? { get set }
    func navigation(from type: MypageNavigationType)
}

