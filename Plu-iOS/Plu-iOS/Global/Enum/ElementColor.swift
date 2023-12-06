//
//  ElementColor.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit

@frozen
enum Elements {
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
}
