//
//  TodayQuestionManagerStub.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/20.
//

import Foundation

final class TodayQuestionManagerStub: TodayQuestionMananger {
    
    func getTodayQuestionResponse() async throws -> TodayQuestionResponse {
        return TodayQuestionResponse(todayQuestionImage: .fire,
                                     myAnswerButtonState: false,
                                     othertAnswerButtonState: true)
    }
}
