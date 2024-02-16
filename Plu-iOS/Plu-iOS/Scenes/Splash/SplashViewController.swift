//
//  SplashViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 Splash. All rights reserved.
//

import UIKit

import SnapKit

protocol SplashNavigation: AnyObject {
    func goToLogin()
    func goToMain()
}

final class SplashViewController: UIViewController {
    
    private let eyeImageView = PLUImageView(nil)
    private let wordMarkView = PLUImageView(ImageLiterals.Splash.pluWordmarkLarge)
    

    weak var delegate: SplashNavigation?

    public override func viewDidLoad() {
        super.viewDidLoad()
        selectRandomElement()
        setHierarchy()
        setLayout()
        requestNotificationPermission()
        DispatchQueue.main.asyncAfter(wallDeadline: .now()+1) {
            self.delegate?.goToLogin()
        }
    }
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { didAllow,Error in
            if didAllow {
                print("Push: 권한 허용")
            } else {
                print("Push: 권한 거부")
            }
        })
    }
}

private extension SplashViewController {
    func selectRandomElement() {
        let randomElement = Elements.allCases.randomElement()!
        setUI(from: randomElement)
    }
    
    func setUI(from element: Elements) {
        self.view.backgroundColor = .designSystem(element.color)
        self.eyeImageView.image = element.eyeImage
    }
    
    func setHierarchy() {
        view.addSubviews(eyeImageView, wordMarkView)
    }
    
    func setLayout() {
        eyeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.25)
            make.height.equalTo(eyeImageView.snp.width).multipliedBy(0.5)
        }
        
        wordMarkView.snp.makeConstraints { make in
            make.top.equalTo(eyeImageView.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.20)
            make.height.equalTo(wordMarkView.snp.width).multipliedBy(0.74)
        }
    }
}
