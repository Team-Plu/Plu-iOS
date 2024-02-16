//
//  MyPageAdaptor.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation

//final class MypageAdaptor: MyPageNavigation {
//
//    weak var delegate: MyPageAdaptorDelegate?
//    
//    var coorinator: MyPageCoordinator
//    init(coorinator: MyPageCoordinator) {
//        self.coorinator = coorinator
//        setDelegate()
//    }
//    
//    func navigation(from type: MypageNavigationType) {
//        switch type {
//        case .header:
//            self.coorinator.showProfileEditViewController()
//        case .back:
//            self.coorinator.pop()
//        case .resign:
//            self.coorinator.showResignViewController()
//        case .logout:
//            print("로그아웃이 눌림")
//        case .alarm:
//            self.coorinator.presentAlarmPopUpViewController()
//        case .faq:
//            print("faq가 눌림")
//        case .openSource:
//            print("오픈소스가 눌림")
//        case .privacy:
//            print("개인정보가 눌림")
//        }
//    }
//    
//    private func setDelegate() {
//        self.coorinator.delegate = self
//    }
//}
//
//extension MypageAdaptor: MypageAlarmResultDelegate {
//    func isAccept() {
//        self.delegate?.isAccept()
//    }
//}
