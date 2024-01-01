//
//  AnswerDetailResponse.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation

struct AnswerDetailResponse {
    let date: String
    let question: String
    let answer: String
    var empathyState: Bool
    var empathyType: Elements
    var empathyCount: Int
}

extension AnswerDetailResponse {
    static let empty = AnswerDetailResponse(date: "Sep 28, 2023", question: "진정한 행복이란\n무엇이라고 생각하시나요?", answer: "진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다 엽떡 만세", empathyState: true, empathyType: .air, empathyCount: 998)
}
