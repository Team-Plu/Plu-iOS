//
//  OthersAnswerNavigation.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation


protocol OthersAnswerNavigation: AnyObject {
    func tableViewCellTapped(id: Int)
    func navigationBackButtonTapped()
}
