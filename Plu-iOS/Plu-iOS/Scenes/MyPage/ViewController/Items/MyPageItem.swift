//
//  MyPageItem.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit

import Carbon
import SnapKit

struct MyPageItem: IdentifiableComponent {
    var title: String
    var onTapped: () -> Void
    var id: String {
        return title
    }
    
    func render(in content: MyPageComponent) {
        content.titleLabel.text = title
        content.onTapped = onTapped
    }
    
    func renderContent() -> MyPageComponent {
        .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(width: bounds.width, height: 52)
    }
}

final class MyPageComponent: UIControl {
    
    var onTapped: (() -> Void)?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .suite(.body1M)
        label.textColor = .designSystem(.black)
        return label
    }()
    
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
        self.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.addSubviews(titleLabel, rightArrow)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
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
