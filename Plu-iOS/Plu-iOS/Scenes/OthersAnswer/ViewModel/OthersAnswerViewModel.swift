//
//  OthersAnswerViewModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation
import Combine

protocol OthersAnswerViewModel: ViewModel where Input == OthersAnswerViewModelInput, Output == OthersAnswerViewModelOutput {}

struct OthersAnswerViewModelInput {
    let viewWillAppear: PassthroughSubject<AnswerFilterButtonType, Never>
    let tableViewCellTapped: PassthroughSubject<Int, Never>
    let filterButtonTapped: PassthroughSubject<AnswerFilterButtonType, Never>
    let navigationBackButtonTapped: PassthroughSubject<Void, Never>
}

struct OthersAnswerViewModelOutput {
    let questions: AnyPublisher<OthersAnswer, Never>
}
