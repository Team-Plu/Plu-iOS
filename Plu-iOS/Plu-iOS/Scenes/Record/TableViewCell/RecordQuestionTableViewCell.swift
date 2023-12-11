//
//  RecordQuestionTableViewCell.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/8/23.
//

import UIKit

class RecordQuestionTableViewCell: UITableViewCell, TableViewCellRegisterDequeueProtocol {

    private let questionView = QuestionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
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
    
    private func setCell() {
        self.backgroundColor = .designSystem(.background)
        self.selectionStyle = .none
    }
    
    private func setHierarchy() {
        self.contentView.addSubview(questionView)
    }
    
    private func setLayout() {
        questionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(_ question: Question) {
        self.questionView.configureUI(question)
    }

}
