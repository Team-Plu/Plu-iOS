//
//  AnswerFilter.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation


protocol AnswerFilter {
    func getOtherAnswers() -> OthersAnswer
}

struct LatestFilter: AnswerFilter {
    func getOtherAnswers() -> OthersAnswer {
        return OthersAnswer.dummmy()
    }
}

struct EmpathyFilter: AnswerFilter {
    func getOtherAnswers() -> OthersAnswer {
        let dummy = OthersAnswer.dummmy()
        let answers = dummy.answers.sorted { lhs, rhs in
            return lhs.empathyCount > rhs.empathyCount
        }
        return OthersAnswer(elementType: dummy.elementType,
                            date: dummy.date,
                            question: dummy.question,
                            answersCount: dummy.answersCount,
                            answers: answers)
    }
}
