//
//  CheckPopUpViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2/19/24.
//

import Foundation
import Combine

protocol CheckPopUpViewModel: ViewModel {
    func transform(input: CheckPopUpInput) -> CheckPopUpOutput
}

struct CheckPopUpInput {
    let leftButtonSubject: PassthroughSubject<Void, Never>
    let rightButtonSubject: PassthroughSubject<Void, Never>
}

struct CheckPopUpOutput {
    let viewDidLoadPublisher: AnyPublisher<CheckPopUpText, Never>
}
