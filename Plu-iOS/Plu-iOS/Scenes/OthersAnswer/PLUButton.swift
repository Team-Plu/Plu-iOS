//
//  PLUButton.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/6/23.
//

import UIKit

final class PLUButton: UIButton {
    
    private var updateHandler: UIButton.ConfigurationUpdateHandler?
    
    init(config: UIButton.Configuration, updateHandler: UIButton.ConfigurationUpdateHandler?) {
        super.init(frame: .zero)
        self.updateHandler = updateHandler
        setUpButton(config: config)
        setHandler()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpButton(config: UIButton.Configuration) {
        self.configuration = config
        self.changesSelectionAsPrimaryAction = true
    }
    
    private func setHandler() {
        self.configurationUpdateHandler = updateHandler
    }
    
    @discardableResult
    func setText(text: String, font: Font.SuiteType) -> Self {
        var config = self.configuration
        var attrString = AttributedString(text)
        attrString.font = .suite(font)
        config?.attributedTitle = attrString
        self.configuration = config
        return self
    }
    
    @discardableResult
    func setImage(image: UIImage, placement: NSDirectionalRectEdge) -> Self {
        var config = self.configuration
        config?.image = image
        config?.imagePlacement = placement
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
}
