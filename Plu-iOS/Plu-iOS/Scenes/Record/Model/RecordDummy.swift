//
//  RecordDummy.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/8/23.
//

import Foundation


struct Record: Hashable {
    let currentDate: String
    let questions: [Question]
}

struct Question: Hashable {
    let id: Int
    let date: String
    let question: String
    let element: Elements
}

extension Record {
    static func dummy() -> Record {
        let questions: [Question] = [
            .init(id: 1, date: "Nov 9, 2023", question: "무엇을 할 때 가장 행복하신가요?", element: .water),
            .init(id: 2, date: "Nov 8, 2023", question: "친구 앞에서 나는 어떤 모습인가요?", element: .air),
            .init(id: 3, date: "Nov 7, 2023", question: "가족 앞에서 나는 어떤 모습인가요?", element: .dust),
            .init(id: 4, date: "Nov 6, 2023", question: "진정한 행복이란 무엇이라고 생각하나요?", element: .fire),
            .init(id: 5, date: "Nov 5, 2023", question: "코딩하고 계신가요?", element: .water),
            .init(id: 6, date: "Nov 4, 2023", question: "공부하고 계신가요?", element: .air),
            .init(id: 7, date: "Nov 3, 2023", question: "알고리즘 공부는요?", element: .dust),
            .init(id: 8, date: "Nov 2, 2023", question: "CS는요?", element: .fire)
        ]
        return Record(currentDate: "2023년 12월", questions: questions)
    }
}
