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
                                    question: "진정한 행복이란\n 무엇이라고 생각하나요?",
                                    answer: "이것은 테스트입니다 텍스트가 알맞게 나오고 있나요?",
                                    empathyState: false,
                                    empathyType: .dust,
                                    empathyCount: 99)
    }
    
    // mock...?
    func empthyStateReqeust(request: EmpthyCountRequest) async throws {
        print("공감 버튼 클릭시 Request를 보냈다고 가정하고")
    }
}
