//
//  OtherAnswersDiffableModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import Foundation


enum OtherAnswersSection {
    case answer
}

enum OtherAnswersItem: Hashable {
    case answer(answer: Answer, element: Elements)
}
