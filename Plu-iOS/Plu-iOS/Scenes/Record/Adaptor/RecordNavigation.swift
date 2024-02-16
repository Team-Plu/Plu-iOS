//
//  RecordNavigation.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation
import Combine


protocol RecordNavigation: AnyObject {
    func dateFilterButtonTapped()
    func tableViewCellTapped(id: Int)
    func navigationRightButtonTapped()
    
    //TODO: POPUP 수정 필요
//    var yearAndMonthSubject: PassthroughSubject<FilterDate?, Never> { get set }
}
