//
//  LoginModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/11/23.
//

import UIKit


enum Login: CaseIterable {
    case page1
    case page2
    case page3
    
    var title: String {
        switch self {
        case .page1:
            return StringConstant.Login.page1Title
        case .page2:
            return StringConstant.Login.page2Title
        case .page3:
            return StringConstant.Login.page3Title
        }
    }
    
    var image: UIImage {
        switch self {
        case .page1:
            return ImageLiterals.Tutorial.screenshot1
        case .page2:
            return ImageLiterals.Tutorial.screenshot2
        case .page3:
            return ImageLiterals.Tutorial.screenshot3
        }
    }
}
