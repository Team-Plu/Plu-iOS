//
//  ProfileItem.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit

import Carbon
import SnapKit

struct ProfileItem: IdentifiableComponent {
    var nickname: String
    var onTapped: () -> Void
    var id: String {
        return nickname
    }
    
    func render(in content: ProfileComponent) {
        content.nickNameLabel.text = nickname
        content.onTapped = onTapped
    }
    func renderContent() -> ProfileComponent {
        .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: bounds.width, height: 110)
    }
}

final class ProfileComponent: UIControl {
    
    var onTapped: (() -> Void)?
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.MyPage.profile60)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nickNameLabel = PLULabel(type: .head2, color: .black)
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.MyPage.arrowRightSmall900)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setLayout()
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    @objc func onTap() {
        self.onTapped?()
    }
}
