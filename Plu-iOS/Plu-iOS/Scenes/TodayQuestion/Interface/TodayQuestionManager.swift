//
//  TodayQuestionManager.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/20.
//

import Foundation

protocol TodayQuestionMananger {
    func getTodayQuestionResponse() async throws -> TodayQuestionResponse
}
