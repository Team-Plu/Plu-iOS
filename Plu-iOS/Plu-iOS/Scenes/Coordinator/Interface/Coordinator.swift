//
//  Coordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

protocol Coordinator : AnyObject, ExitUser {
    var navigationController : UINavigationController? { get set }
}
