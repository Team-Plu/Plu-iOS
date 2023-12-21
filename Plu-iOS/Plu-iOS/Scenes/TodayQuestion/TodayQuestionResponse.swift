//
//  TodayQuestionResponse.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/20.
//

import UIKit

enum ImageType {
    case air, fire, dust, water
    
    var image: UIImage {
        switch self {
        case .air:
            return ImageLiterals.Main.airTodayQuestion
        case .fire:
            return ImageLiterals.Main.fireTodayQuestion
        case .dust:
            return ImageLiterals.Main.dustTodayQuestion
        case .water:
            return ImageLiterals.Main.waterTodayQuestion
        }
    }
}

struct TodayQuestionResponse {
    let todayQuestionImage: ImageType
    let myAnswerButtonState: Bool
    let othertAnswerButtonState: Bool
}

extension TodayQuestionResponse {
    static let empty = TodayQuestionResponse(todayQuestionImage: .fire,
                                             myAnswerButtonState: false,
                                             othertAnswerButtonState: true)
}
