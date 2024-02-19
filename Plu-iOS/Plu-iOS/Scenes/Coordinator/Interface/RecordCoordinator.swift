//
//  RecordCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation
import Combine

protocol RecordCoordinator: Coordinator {
    var yearAndMonthSubject: PassthroughSubject<FilterDate, Never> { get set }
    func showRecordViewController()
    func showMyPageViewController()
    func presentSelectMonthPopUpViewController()
    func showAnswerDetailViewController(id: Int)
}
