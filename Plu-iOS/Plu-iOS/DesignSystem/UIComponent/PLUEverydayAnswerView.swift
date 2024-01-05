//
//  EveryAnswerView.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/11.
//

/**
 1. view 자체에 inset 값을 모두 주었기 때문에, 사용하려는 VC에 top, leading, trailing 값 줄 필요 없이 붙이기만 하면 됨.
 
 everydayAnswerView.snp.makeConstraints { make in
     make.top.equalTo(view.safeAreaLayoutGuide)
     make.leading.trailing.equalToSuperview()
 }
 **/

import UIKit

final class PLUEverydayAnswerView: UIView {
    private let dateLabel = PLULabel(type: .body2R, color: .gray500, backgroundColor: .background)
    private let questionLabel = PLULabel(type: .head1, color: .gray800, backgroundColor: .background,
                                         alignment: .center, lines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setHierarchy()
        setLayout()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(date: String, question: String) {
        self.dateLabel.text = date
        self.questionLabel.text = question
    }
}

private extension PLUEverydayAnswerView {
    func setUI() {
        backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        addSubviews(dateLabel, questionLabel)
    }
    
    func setLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.centerX.equalTo(dateLabel)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

