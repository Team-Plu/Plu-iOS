//
//  ResignDescriptionView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/9/23.
//

import UIKit

final class ResignDescriptionView: UIView {
    
    private var descriptionLabel = PLULabel(type: .body3,
                                            color: .gray700,
                                            backgroundColor: .gray10,
                                            alignment: .left,
                                            lines: 4,
                                            text: StringConstant.Resign.resignDescriptionText)
        .setLineSpacing(10)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .designSystem(.gray10)
        self.layer.borderColor = .designSystem(.gray10)
        self.layer.applyShadow()
        self.layer.cornerRadius = 20
    }
    
    private func setHierachy() {
        self.addSubviews(descriptionLabel)
    }
    
    private func setLayout() {
        descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(20)
        }
    }

}
