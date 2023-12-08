//
//  OthersAnswerTableView.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit

final class OthersAnswerTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
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
        AnswerTableViewCell.register(to: self)
    }
}
