//
//  AnswerDetailViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation
import Combine

protocol AnswerDetailViewModel: ViewModel where Input == AnswerDetailViewModelInput, Output == AnswerDetailViewModelOuput {}

struct AnswerDetailViewModelInput {
    let leftButtonTapped: PassthroughSubject<Void, Never>
    let viewWillAppearSubject: PassthroughSubject<Void, Never>
    let empathyButtonTappedSubject: PassthroughSubject<(EmpthyCountRequest, CountType), Never>
}

struct AnswerDetailViewModelOuput {
    let viewWillAppearResult: AnyPublisher<AnswerDetailResponse, Never>
    let empathyButtonResult: AnyPublisher<EmpthyCountResponse, Never>
}
