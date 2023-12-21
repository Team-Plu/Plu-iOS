//
//  AnswerDetailStub.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation

final class AnswerDetailStub: AnswerDetailManager {
    
    func answerDetailResponse() async throws -> AnswerDetailResponse {
        return AnswerDetailResponse(date: "Sep 28, 2023",
                                    title: "진정한 행복이란\n 무엇이라고 생각하나요?",
                                    contents: "진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다 엽떡 만세",
                                    empathyCount: 998)
    }
    
}
