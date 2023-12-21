//
//  TodayQuestionViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/19.
//

import Foundation
import Combine

protocol TodayQuestionViewModel: ViewModel where Input == TodayQuestionViewModelInput, Output == TodayQuestionViewModelOutput {}

struct TodayQuestionViewModelInput {
    let isShownAlarmPopupSubject: PassthroughSubject<Void, Never>
    let navigationRightButtonTapped: PassthroughSubject<Void, Never>
    let myAnswerButtonTapped: PassthroughSubject<Void, Never>
    let otherAnswerButtonTapped: PassthroughSubject<Void, Never>
    let viewWillAppearSubject: PassthroughSubject<Void, Never>
}

struct TodayQuestionViewModelOutput {
    let viewWillAppearSubject: AnyPublisher<TodayQuestionResponse, Never>
}
