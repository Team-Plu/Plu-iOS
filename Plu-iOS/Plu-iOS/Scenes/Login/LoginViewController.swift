//
//  LoginViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 Login. All rights reserved.
//

import UIKit

import SnapKit

final class LoginViewController: UIViewController {
    
    var coordinator: AuthCoordinator
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .designSystem(.gray700)
        pageControl.pageIndicatorTintColor = .designSystem(.gray100)
        return pageControl
    }()
    
    private let elementalsImageView = UIImageView(image: ImageLiterals.Tutorial.characterSet)
    
    private lazy var tutorialCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .designSystem(.background)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        TutorialCollectionViewCell.register(to: collectionView)
        return collectionView
    }()
    
    private let kakaoLoginButton = PLUButton(config: .filled())
        .setText(text: "카카오로 시작하기", font: .title1)
        .setBackForegroundColor(backgroundColor: .kakaoYellow, foregroundColor: .black)
        .setImage(image: ImageLiterals.Tutorial.kakaoLogo, placement: .leading)
    
    
    
    private let appleLoginButton = PLUButton(config: .filled())
        .setText(text: "Apple로 시작하기", font: .title1)
        .setBackForegroundColor(backgroundColor: .black, foregroundColor: .white)
        .setImage(image: ImageLiterals.Tutorial.AppleLogo, placement: .leading)
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDataSource()
        kakaoLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

private extension LoginViewController {
    
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(pageControl, elementalsImageView, tutorialCollectionView, kakaoLoginButton, appleLoginButton)
    }
    
    func setLayout() {
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(67)
            make.centerX.equalToSuperview()
        }
        
        elementalsImageView.snp.makeConstraints { make in
            make.centerX.equalTo(pageControl)
            make.top.equalTo(pageControl.snp.bottom).offset(36)
        }
        
        tutorialCollectionView.snp.makeConstraints { make in
            make.top.equalTo(elementalsImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(tutorialCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(44.seHeight)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(12)
            make.leading.trailing.equalTo(kakaoLoginButton)
            make.height.equalTo(44.seHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
    }
    
    func setDataSource() {
        self.tutorialCollectionView.dataSource = self
        self.tutorialCollectionView.delegate = self
    }
    
    @objc func loginButtonTapped() {
        self.coordinator.showOnboardingController()
    }
}

// MARK: CollectionView DataSource

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
}

extension LoginViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) 
    -> Int {
        return Login.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TutorialCollectionViewCell.dequeueReusableCell(to: collectionView, indexPath: indexPath)
        let title = Login.allCases[indexPath.item].title
        let image = Login.allCases[indexPath.item].image
        
        cell.configureCell(image: image, text: title)
        return cell
    }
}
