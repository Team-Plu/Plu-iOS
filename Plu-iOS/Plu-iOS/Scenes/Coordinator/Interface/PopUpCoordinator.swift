//
//  PopUpCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation


//protocol AlarmPopUp: Coordinator {
//    func
//}
//
//protocol RegisterPopUp: Coordinator {
//    
//}
//
//protocol SelectMonthPopUp: Coordinator {
//    
//}

@frozen
enum PopUpType {
    case alarm
    case register
    case selectMonth(year: Int, month: Int)
}

protocol PopUpCoordinator: Coordinator {
    func show(type: PopUpType)
    func accept(type: PopUpType)
    func dismiss()
}

