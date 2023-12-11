//
//  se+.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/11/23.
//

import UIKit

extension CGFloat {

    var seWidth: CGFloat {
        let ratio = UIScreen.main.bounds.width / 375
        return self * ratio
    }
    
    var seHeight: CGFloat {
        let ratio = UIScreen.main.bounds.height / 667
        return self * ratio
    }
}

extension Double {
    var seWidth: Double {
        let ratio = UIScreen.main.bounds.width / 375
        return Double(CGFloat(self) * ratio)
    }
    
    var seHeight: Double {
        let ratio = UIScreen.main.bounds.height / 667
        return Double(CGFloat(self) * ratio)
    }
}


extension Int {

    var seWidth: Int {
        let ratio = UIScreen.main.bounds.width / 375
        return Int(CGFloat(self) * ratio)
    }
    
    var seHeight: Int {
        let ratio = UIScreen.main.bounds.height / 667
        return Int(CGFloat(self) * ratio)
    }
}
