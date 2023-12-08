//
//  QuestionView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/8/23.
//

import UIKit

final class QuestionView: UIView {
    
    private let dateLabel: PLULabel = {
        let label = PLULabel(type: .body2M, color: .white)
        label.backgroundColor = .clear
        return label
    }()
    
    private let questionLabel: PLULabel = {
        let label = PLULabel(type: .title1, color: .white)
        label.backgroundColor = .clear
        return label
    }()
    
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
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
    
    private func setHierachy() {
        self.addSubviews(dateLabel, questionLabel)
    }
    
    private func setLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32).priority(.high)
            make.leading.equalToSuperview().inset(24)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(dateLabel)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    func configureView(_ question: Question) {
        dateLabel.text = question.date
        questionLabel.text = question.question
        self.backgroundColor = .designSystem(question.element.color) 
    }

}
