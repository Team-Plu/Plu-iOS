//
//  Coordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

protocol Coordinator : AnyObject {
//    var parentCoordinator: Coordinator? { get set }
//    var children: [Coordinator] { get set }
    var navigationController : UINavigationController? { get set }
}

//extension Coordinator {
//    
//    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
//    /// - Parameter coordinator: Coordinator that finished.
//    func childDidFinish(_ coordinator : Coordinator){
//        // Call this if a coordinator is done.
//        for (index, child) in children.enumerated() {
//            if child === coordinator {
//                children.remove(at: index)
//                break
//            }
//        }
//    }
//}
