//
//  ElementColor.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit

@frozen
enum Elements: CaseIterable {
    case water
    case air
    case dust
    case fire
    
    var color: Palette {
        switch self {
        case .water:
            return .pluBlue
        case .air:
            return .pluGray
        case .dust:
            return .pluBrown
        case .fire:
            return .pluRed
        }
    }
    
    var empathyImage: UIImage {
        switch self {
        case .water:
            return ImageLiterals.Respone.waterEmpathySmall
        case .air:
            return ImageLiterals.Respone.airEmpathySmall
        case .dust:
            return ImageLiterals.Respone.dustEmpathySmall
        case .fire:
            return ImageLiterals.Respone.fireEmpathySmall
        }
    }
    
    var characterSmallImage: UIImage {
        switch self {
        case .water:
            return ImageLiterals.Respone.waterCharacterSmall
        case .air:
            return ImageLiterals.Respone.airCharacterSmall
        case .dust:
            return ImageLiterals.Respone.dustCharacterSmall
        case .fire:
            return ImageLiterals.Respone.fireCharacterSmall
        }
    }
    
    var eyeImage: UIImage {
        switch self {
        case .water:
            return ImageLiterals.Splash.waterEye
        case .air:
            return ImageLiterals.Splash.airEye
        case .dust:
            return ImageLiterals.Splash.dustEye
        case .fire:
            return ImageLiterals.Splash.fireEye
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
