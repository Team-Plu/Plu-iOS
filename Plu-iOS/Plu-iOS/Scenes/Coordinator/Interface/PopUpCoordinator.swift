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
    case selecMonth
}

protocol PopUpCoordinator: Coordinator {
    func accept(type: PopUpType)
    func dismiss()
}

