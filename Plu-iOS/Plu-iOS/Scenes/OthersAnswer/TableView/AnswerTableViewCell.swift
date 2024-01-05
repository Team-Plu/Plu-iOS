//
//  AnswerTableViewCell.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit

final class AnswerTableViewCell: UITableViewCell {
    
    private let answerView = AnswerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 21, bottom: 8, right: 21))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .designSystem(.background)
        self.selectionStyle = .none
    }
    
    private func setHierarchy() {
        self.contentView.addSubview(answerView)
    }
    
    private func setLayout() {
        answerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureUI(_ answer: Answer, element: Elements) {
        self.answerView.configureUI(answer, element: element)
    }
}
