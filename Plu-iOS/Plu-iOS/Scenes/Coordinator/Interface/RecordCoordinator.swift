//
//  RecordCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation


protocol RecordCoordinator: Coordinator {
    func showRecordViewController()
    func showMyPageViewController()
    func presentSelectMonthPopUpViewController()
    func showAnswerDetailViewController()
    
    var delegate: RecordCoordinatorDelegate? { get set }
}
