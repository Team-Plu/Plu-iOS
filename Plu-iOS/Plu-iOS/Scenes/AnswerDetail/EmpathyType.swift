//
//  EmpathyType.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import UIKit

enum EmpathyType {
    case air, fire, dust, water
    
    var color: Palette {
        switch self {
        case .air:
            return .pluGray
        case .fire:
            return .pluRed
        case .dust:
            return .pluBrown
        case .water:
            return .pluBlue
        }
    }
    
    var activeEmpathy: UIImage {
        switch self {
        case .air:
            return ImageLiterals.AnswerDetail.airEmpathyLargeActivated
        case .fire:
            return ImageLiterals.AnswerDetail.fireEmpathyLargeActivated
        case .dust:
            return ImageLiterals.AnswerDetail.dustEmpathyLargeActivated
        case .water:
            return ImageLiterals.AnswerDetail.waterEmpathyLargeActivated
        }
    }
    
    var inActiveEmpathy: UIImage {
        switch self {
        case .air:
            return ImageLiterals.AnswerDetail.airEmpathyLargeInactivated
        case .fire:
            return ImageLiterals.AnswerDetail.fireEmpathyLargeInactivated
        case .dust:
            return ImageLiterals.AnswerDetail.dustEmpathyLargeInactivated
        case .water:
            return ImageLiterals.AnswerDetail.waterEmpathyLargeInactivated
        }
    }
}
