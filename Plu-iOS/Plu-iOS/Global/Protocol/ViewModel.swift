//
//  ViewModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import UIKit

protocol ViewModel where Self: AnyObject {
    associatedtype Input
    associatedtype Output
    
    @MainActor func transform(input: Input) -> Output
}
