//
//  AnswerCautionView.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/09.
//

import UIKit

final class AnswerCautionView: UIView {
    
    private let underLine = PLUUnserLine(color: .gray100)
    private let cautionLabel = PLULabel(type: .body2M, color: .gray700, text: StringConstant.MyAnswer.titleCaution.text)
    private let firstCautionPoint = PLULabel(type: .body3, color: .gray400, text: StringConstant.MyAnswer.cautionPoint.text)
    private let secondCautionPoint = PLULabel(type: .body3, color: .gray400, text: StringConstant.MyAnswer.cautionPoint.text)
    private let cautionPointStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let firstCautionLabel = PLULabel(type: .body3, color: .gray400, text: StringConstant.MyAnswer.firstCaution.text)
    private let secondCautionLabel = PLULabel(type: .body3, color: .gray400, lines: 3, text: StringConstant.MyAnswer.secondCaution.text)
    private let cautionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()
    
    private let bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setHierarchy()
        setLayout()
        setLineHeight()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(underLine, cautionLabel, cautionPointStackView, cautionStackView)
        cautionPointStackView.addArrangedSubviews(firstCautionPoint, secondCautionPoint)
        cautionStackView.addArrangedSubviews(firstCautionLabel, secondCautionLabel)
    }
    
    private func setLayout() {
        underLine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        cautionLabel.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        cautionPointStackView.snp.makeConstraints { make in
            make.top.equalTo(cautionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
        }
        
        cautionStackView.snp.makeConstraints { make in
            make.top.equalTo(cautionPointStackView)
            make.leading.equalTo(cautionPointStackView.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setLineHeight() {
        cautionLabel.setTextWithLineHeight(lineHeight: 22)
        firstCautionPoint.setTextWithLineHeight(lineHeight: 20)
        secondCautionPoint.setTextWithLineHeight(lineHeight: 20)
        firstCautionLabel.setTextWithLineHeight(lineHeight: 20)
        secondCautionLabel.setTextWithLineHeight(lineHeight: 20)
    }
}
