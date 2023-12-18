//
//  SplashViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 Splash. All rights reserved.
//

import UIKit

import SnapKit

final class SplashViewController: UIViewController {
    
    let coordinator: SplashCoordinator
    
    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let eyeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let wordMarkView: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.Splash.pluWordmarkLarge)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("sofjisofjsoi", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        selectRandomElement()
        setHierarchy()
        setLayout()
        requestNotificationPermission()
    }
    
    @objc func tap() {
        self.coordinator.showLoginViewController()
    }
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
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
        view.addSubviews(eyeImageView, wordMarkView, button)
    }
    
    func setLayout() {
        eyeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.77)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.25)
            make.height.equalTo(eyeImageView.snp.width).multipliedBy(0.5)
        }
        
        wordMarkView.snp.makeConstraints { make in
            make.top.equalTo(eyeImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.20)
            make.height.equalTo(wordMarkView.snp.width).multipliedBy(0.74)
        }
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
}
