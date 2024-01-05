//
//  OnboardingNavigation.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation

protocol Navigation {
    associatedtype NavigationType
    func navigation(from type: NavigationType)
}

protocol OnboardingNavigation: Navigation where NavigationType == OnboardingNavigationType {}


