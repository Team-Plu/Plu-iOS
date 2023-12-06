//
//  Dummy.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import Foundation


struct OthersAnswer: Hashable {
    let elementType: Elements
    let date: String
    let question: String
    let answersCount: Int
    let answers: [Answer]
}

struct Answer: Hashable {
    let answerText: String
    let empathyCount: Int
}

extension OthersAnswer {
    static func dummmy() -> OthersAnswer {
        let answer: [Answer] = [
            .init(answerText: "진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다. 엽떡 만세", empathyCount: 1),
            .init(answerText: "나는 아무 생각이없다.", empathyCount: 998),
            .init(answerText: "나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.", empathyCount: 1),
            .init(answerText: "나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.", empathyCount: 9999),
            .init(answerText: "나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.", empathyCount: 9999),
            .init(answerText: "나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.", empathyCount: 123),
            .init(answerText: "나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.", empathyCount: 4),
            .init(answerText: "나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.나는 아무 생각이없다.", empathyCount: 2),
        ]
        return .init(elementType: .water, date: "Sep 28, 2023", question: "진정한 행복이란\n무엇이라고 생각하나요?", answersCount: 4, answers: answer)
    }
}
