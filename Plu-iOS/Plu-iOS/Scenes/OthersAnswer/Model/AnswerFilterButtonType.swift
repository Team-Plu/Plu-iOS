//
//  AnswerFilterButtonType.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation


enum AnswerFilterButtonType {
    case latest
    case mostEmpathy
    
    var object: AnswerFilter {
        switch self {
        case .latest:
            return LatestFilter()
        case .mostEmpathy:
            return EmpathyFilter()
        }
    }
    
    var title: String {
        switch self {
        case .latest:
            return "최신순"
        case .mostEmpathy:
            return "공감순"
        }
    }
}
