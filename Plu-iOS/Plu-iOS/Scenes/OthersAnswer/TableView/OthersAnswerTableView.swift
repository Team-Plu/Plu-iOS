//
//  OthersAnswerTableView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit

enum QATableViewType {
    case othersAnswers
    case recordQuestions
}

final class OthersAnswerTableView: UITableView {
    
    private let type: QATableViewType
    
    init(tableViewType: QATableViewType) {
        self.type = tableViewType
        super.init(frame: .zero, style: .plain)
        setUI()
        setTableView()
        registerCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .designSystem(.background)
    }
    
    private func setTableView() {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 150
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
    }
    
    private func registerCell() {
        if type == .othersAnswers {
            AnswerTableViewCell.register(to: self)
        } else {
            RecordQuestionTableViewCell.register(to: self)
        }
    }
}
