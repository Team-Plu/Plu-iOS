//
//  CountType.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/22.
//

import Foundation

enum CountType {
    case up, down
    
    var addValue: Int {
        switch self {
        case .up:
            return 1
        case .down:
            return -1
        }
    }
}
