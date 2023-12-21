//
//  OthersAnswerManager.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation

protocol OthersAnswerManager {
    func getAnswers(filter: AnswerFilter) async throws -> OthersAnswer
}
