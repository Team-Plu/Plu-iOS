//
//  RecordNavigation.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation
import Combine


protocol RecordNavigation {
    func dateFilterButtonTapped()
    func tableViewCellTapped(id: Int)
    func navigationRightButtonTapped()
    
    var yearAndMonthSubject: PassthroughSubject<FilterDate?, Never> { get set }
}
