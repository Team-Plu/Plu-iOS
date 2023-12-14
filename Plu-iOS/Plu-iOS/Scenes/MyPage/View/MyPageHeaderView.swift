//
//  MyPageHeaderView.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//  Copyright (c) 2023 MyPageHeader. All rights reserved.
//

import UIKit

import SnapKit

final class MyPageHeaderView: UIView {
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.MyPage.profile60)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .suite(.head2)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.MyPage.arrowRightSmall900)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .init(x: 0, y: 0, width: ScreenConstant.Screen.width, height: 100))
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(_ input: String) {
        self.nickNameLabel.text = input
    }

}

private extension MyPageHeaderView {
    func setUI() {
        self.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.addSubviews(profileImage, nickNameLabel, rightArrow)
    }
    
    func setLayout() {
        profileImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(60)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }
        
        rightArrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(24)
        }
    }
}
