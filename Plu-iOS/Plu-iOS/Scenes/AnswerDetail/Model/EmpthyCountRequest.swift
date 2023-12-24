//
//  EmpthyCountRequest.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation

struct EmpthyCountRequest {
    let empthyState: Bool
    let empthyCount: Int
}

struct EmpthyCountResponse {
    let empthyType: EmpathyType
    let empthyState: Bool
    let empthyCount: Int
}
