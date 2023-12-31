//
//  PLUButton.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/6/23.
//

import UIKit

final class PLUButton: UIButton {
    
    private var buttonFont: Font.SuiteType?
    private var buttonTitle: String?
        
    init(config: UIButton.Configuration) {
        super.init(frame: .zero)
        setUpButton(config: config)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpButton(config: UIButton.Configuration) {
        self.configuration = config
        self.changesSelectionAsPrimaryAction = true
    }
    
    @discardableResult
    func setText(text: String, font: Font.SuiteType) -> Self {
        var config = self.configuration
        var attrString = AttributedString(text)
        attrString.font = .suite(font)
        config?.attributedTitle = attrString
        self.buttonFont = font
        self.configuration = config
        return self
    }
    
    @discardableResult
    func setImage(image: UIImage, placement: NSDirectionalRectEdge, padding: CGFloat = 8) -> Self {
        var config = self.configuration
        config?.image = image
        config?.imagePlacement = placement
        config?.imagePadding = padding
        self.configuration = config
        return self
    }
    
    @discardableResult
    func setBackForegroundColor(backgroundColor: Palette, foregroundColor: Palette) -> Self {
        var config = self.configuration
        config?.baseBackgroundColor = .designSystem(backgroundColor)
        config?.baseForegroundColor = .designSystem(foregroundColor)
        self.configuration = config
        return self
    }
    
    @discardableResult
    func setLayer(cornerRadius: CGFloat, borderColor: Palette, borderWidth: CGFloat = 1) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = .designSystem(borderColor)
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setLayer(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        return self
    }
    
    func setUpdateHandler(updateHandler: UIButton.ConfigurationUpdateHandler?) {
        self.configurationUpdateHandler = updateHandler
    }
    
    @discardableResult
    func underLine(title: String?) -> Self {
        self.setUnderline(title: title)
        return self
    }
    
    func setActivityIndicator(isShow: Bool, isImage: Bool) {
        
        var config = self.configuration
        config?.showsActivityIndicator = isShow
        
        if isShow  { // 로딩
            if !isImage { // 이미지가 없는 버튼일 경우
                self.buttonTitle = self.titleLabel?.text
                config?.attributedTitle = nil
            }
        } else { // 로딩 끝
            if !isImage { // 이미지가 없는 버튼
                guard let font = self.buttonFont,
                      let title = self.buttonTitle
                else { return }
                var attrString = AttributedString(title)
                attrString.font = .suite(font)
                config?.attributedTitle = attrString
            }
        }
        
        self.configuration = config
    }
    
    func isActive(state: Bool) {
        var config = self.configuration
        config?.baseBackgroundColor = .designSystem(state ? .gray600 : .gray50)
        config?.baseForegroundColor = .designSystem(state ? .white : .gray300)
        self.configuration = config
        self.isEnabled = state
    }
}
