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

    public override func viewDidLoad() {
        super.viewDidLoad()
        selectRandomElement()
        setHierarchy()
        setLayout()
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
    }
}
