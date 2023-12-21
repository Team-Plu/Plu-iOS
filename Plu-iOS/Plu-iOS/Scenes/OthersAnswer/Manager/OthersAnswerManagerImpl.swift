//
//  OthersAnswerManagerImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation


final class OthersAnswerManagerImpl: OthersAnswerManager {
    func getAnswers(type: AnswerFilterButtonType) -> OthersAnswer {
        switch type {
        case .latest:
            return OthersAnswer.dummmy()
        case .mostEmpathy:
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
}
