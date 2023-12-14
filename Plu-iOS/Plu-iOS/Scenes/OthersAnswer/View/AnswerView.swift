//
//  AnswerView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit

final class AnswerView: UIView {
    
    private let answerLabel = PLULabel(type: .body2M, color: .gray700, backgroundColor: .gray10, lines: 3)
    
    private let elementImageView = UIImageView()
    
    private let empathyCountLabel = PLULabel(type: .title2, color: .pluBlue, backgroundColor: .gray10)
    
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
        self.layer.applyShadow(alpha: 0.2)
        self.layer.cornerRadius = 12
    }
    
    private func setHierachy() {
        self.addSubviews(answerLabel, elementImageView, empathyCountLabel)
        
    }
    
    private func setLayout() {
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32).priority(.high)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        elementImageView.snp.makeConstraints { make in
            make.top.equalTo(answerLabel.snp.bottom).offset(12)
        }
        
        empathyCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(answerLabel)
            make.centerY.equalTo(elementImageView)
            make.leading.equalTo(elementImageView.snp.trailing).offset(4)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    func configureUI(_ answer: Answer, element: Elements) {
        let empathyCount = answer.empathyCount > 999 ? "999+" : answer.empathyCount.description
        
        answerLabel.text = answer.answerText
        empathyCountLabel.text = empathyCount
        elementImageView.image = element.empathyImage
    }
}
