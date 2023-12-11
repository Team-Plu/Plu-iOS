//
//  AnswerFilterMenuView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/6/23.
//

import UIKit

final class AnswerFilterMenuView: UIView {

    let latestLabel = PLULabel(type: .body3, color: .gray700, backgroundColor: .background, text: "최신순")
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.gray50)
        return view
    }()
    
    let empathyFilterLabel = PLULabel(type: .body3, color: .gray700, backgroundColor: .background, text: "공감순")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.borderColor = .designSystem(.gray500)
        self.layer.borderWidth = 1
        setHierarchy()
        setLayout()
        self.backgroundColor = .designSystem(.background)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setHierarchy() {
        self.addSubviews(latestLabel, lineView, empathyFilterLabel)
    }
    
    private func setLayout() {
        latestLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(latestLabel.snp.bottom).offset(6)
            make.height.equalTo(1)
            make.width.equalToSuperview().inset(6)
            make.centerX.equalTo(latestLabel)
        }
        
        empathyFilterLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(6)
            make.bottom.equalToSuperview().inset(12)
            make.centerX.equalTo(latestLabel)
        }
    }
    
}
