//
//  PLUNavigationBarView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/14/23.
//

import UIKit
import Combine

final class PLUNavigationBarView: UIView {
    // MARK: - Public Subjects
    let leftButtonTapSubject = PassthroughSubject<Void, Never>()
    let rightButtonTapSubject = PassthroughSubject<Void, Never>()
    
    enum LeftButtonType {
        case logo
        case textLogo
        case back
        
        var image: UIImage {
            switch self {
            case .back: return ImageLiterals.NavigationBar.arrowLeft
            case .logo: return ImageLiterals.NavigationBar.profile32
            case .textLogo: return ImageLiterals.NavigationBar.pluSmallLogo
            }
        }
    }
    
    enum RightButtonType {
        case logo
        case text(String)
        
        var image: UIImage? {
            switch self {
            case .logo: return ImageLiterals.NavigationBar.profile32
            default: return nil
            }
        }
    }
    
    private let leftButton = PLUButton(config: .plain())
    
    private let titleLabel = PLULabel(type: .head3, color: .gray800)
    
    private let rightButton = PLUButton(config: .plain())
    
    private var cancelBag = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setHierarchy()
        setLayout()
        bindInput()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindInput() {
        leftButton.tapPublisher
            .sink { [weak self] _ in
                guard let self else { return }
                self.leftButtonTapSubject.send(())
            }
            .store(in: &cancelBag)
        
        rightButton.tapPublisher
            .sink { [weak self] _ in
                guard let self else { return }
                self.rightButtonTapSubject.send(())
            }
            .store(in: &cancelBag)
    }
    
    @discardableResult
    func setTitle(text: String) -> Self {
        self.titleLabel.text = text
        return self
    }
    
    @discardableResult
    func setLeftButton(type: LeftButtonType) -> Self {
        leftButton.setImage(image: type.image, placement: .all)
        return self
    }
    
    @discardableResult
    func setRightButton(type: RightButtonType) -> Self {
        rightButton.isHidden = false
        switch type {
        case .logo:
            rightButton.setImage(image: type.image!, placement: .all)
        case .text(let text):
            rightButton.setText(text: text, font: .subHead1)
            rightButton.setBackForegroundColor(backgroundColor: .background, foregroundColor: .gray200)
        }
        return self
    }
    
    func setRightButtonInitState(isEnabeld: Bool) -> Self {
        rightButton.isEnabled = isEnabeld
        return self
    }
    
    func setRightButtonState(isEnabled: Bool) {
        let buttonTitleColor = isEnabled ? Palette.gray600 : Palette.gray200
        rightButton.setBackForegroundColor(backgroundColor: .background, foregroundColor: buttonTitleColor)
        rightButton.isEnabled = isEnabled
        var config = rightButton.configuration
        config?.baseForegroundColor = .designSystem(isEnabled ? .gray600 : .gray200)
        rightButton.configuration = config
    }
    
    func setActivityIndicator(isShow: Bool, isImage: Bool) {
        self.rightButton.setActivityIndicator(isShow: isShow, isImage: isImage)
    }
}

extension PLUNavigationBarView {
    private func configureUI() {
        rightButton.isHidden = true
    }
    
    private func setHierarchy() {
        self.addSubviews(leftButton, titleLabel, rightButton)
    }
    
    private func setLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        leftButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel)
        }
    }
}
