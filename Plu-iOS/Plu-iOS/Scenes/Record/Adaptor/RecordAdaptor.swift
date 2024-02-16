//
//  RecordAdaptor.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation
import Combine

//final class RecordAdaptor: RecordNavigation {
//    
//    var yearAndMonthSubject = PassthroughSubject<FilterDate?, Never>()
//    
//    private let coordinator: RecordCoordinator
//    private var cancelBag = Set<AnyCancellable>()
//    
//    init(coordinator: RecordCoordinator) {
//        self.coordinator = coordinator
//        bindInput()
//    }
//    
//    func dateFilterButtonTapped() {
//        self.coordinator.presentSelectMonthPopUpViewController()
//    }
//    
//    func tableViewCellTapped(id: Int) {
//        self.coordinator.showAnswerDetailViewController(id: id)
//    }
//    
//    func navigationRightButtonTapped() {
//        self.coordinator.showMyPageViewController()
//    }
//    
//    private func bindInput() {
//        coordinator.yearAndMonthSubject
//            .sink { [weak self] date in
//                self?.yearAndMonthSubject.send(date)
//            }
//            .store(in: &cancelBag)
//    }
//}
