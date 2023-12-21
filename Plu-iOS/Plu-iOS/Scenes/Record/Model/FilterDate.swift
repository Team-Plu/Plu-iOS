//
//  FilterDate.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation


struct FilterDate {
    let year: Int
    let month: Int
}

extension FilterDate {
    static var empty: FilterDate {
        return .init(year: .zero, month: .zero)
    }
}
