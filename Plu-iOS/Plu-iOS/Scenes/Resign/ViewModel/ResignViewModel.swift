//
//  ResignViewModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation
import Combine

protocol ResignViewModel: ViewModel where Input == ResignViewModelInput, Output == ResignViewModelOutput {}

struct ResignViewModelInput {
    let navigationBackButtonTapped: PassthroughSubject<Void, Never>
    let checkBoxButtonTapped: PassthroughSubject<Bool, Never>
    let resignButtonTapped: PassthroughSubject<Void, Never>
}

struct ResignViewModelOutput {
    let resignButtonStatePublisher: AnyPublisher<Bool, Never>
}

