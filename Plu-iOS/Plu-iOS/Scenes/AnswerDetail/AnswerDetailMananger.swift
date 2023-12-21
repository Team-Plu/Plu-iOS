//
//  AnswerDetailMananger.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation

protocol AnswerDetailManager {
    func answerDetailResponse() async throws -> AnswerDetailResponse
}
