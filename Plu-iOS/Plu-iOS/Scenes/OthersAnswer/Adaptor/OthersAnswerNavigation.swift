//
//  OthersAnswerNavigation.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation
import Combine


protocol OthersAnswerNavigation {
    func tableViewCellTapped(id: Int)
    func navigationBackButtonTapped()
}
