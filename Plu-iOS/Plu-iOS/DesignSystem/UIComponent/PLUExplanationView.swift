//
//  PLUExplanationView.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/10.
//

import UIKit

final class PLUExplanationView: UIView {
    
    private let explanationLabel = PLULabel(type: .body3, color: .gray700, backgroundColor: .gray10, lines: 0)
    
    init(text: String) {
        super.init(frame: .zero)

        setHierarchy()
        setLayout()
        setUI()
        
        explanationLabel.text = text
        explanationLabel.setTextWithLineHeight(lineHeight: 20)
        explanationLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = .designSystem(.gray10)
        roundCorners(cornerRadius: 8, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        layer.cornerRadius = 20
        layer.shadowOpacity = 1
        layer.shadowColor = .designSystem(.gray100)
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
    
    func setHierarchy() {
        addSubview(explanationLabel)
    }
    
    func setLayout() {
        explanationLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
}
