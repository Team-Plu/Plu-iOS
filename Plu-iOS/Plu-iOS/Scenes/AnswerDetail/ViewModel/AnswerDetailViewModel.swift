//
//  AnswerDetailViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation
import Combine

protocol AnswerDetailPresentable {
    func setAnswerId(id: Int)
}

protocol AnswerDetailViewModel: ViewModel where Input == AnswerDetailViewModelInput, Output == AnswerDetailViewModelOuput {}

struct AnswerDetailViewModelInput {
    let leftButtonTapped: PassthroughSubject<Void, Never>
    let viewWillAppearSubject: PassthroughSubject<Void, Never>
    let empathyButtonTappedSubject: PassthroughSubject<Void, Never>
}

struct AnswerDetailViewModelOuput {
    let viewWillAppearResult: AnyPublisher<AnswerDetailResponse, Never>
    let empathyButtonResult: AnyPublisher<EmpthyCountResponse, Never>
}
