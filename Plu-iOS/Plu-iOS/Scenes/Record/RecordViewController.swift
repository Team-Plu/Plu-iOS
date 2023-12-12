//
//  RecordViewController.swift
//  Plu-iOS
//
//  Created by 김민재 on 2023/12/08.
//  Copyright (c) 2023 Record. All rights reserved.
//

import UIKit

import SnapKit

final class RecordViewController: UIViewController {
    
    var coordinator: RecordCoordinator
    
    private let totalCountLabel = PLULabel(type: .subHead1, color: .gray600, backgroundColor: .background)
    
    private let dateFilterButton = PLUButton(config: .bordered())
        .setImage(image: ImageLiterals.Respone.arrowDownSmall600, placement: .trailing)
        .setBackForegroundColor(backgroundColor: .background, foregroundColor: .gray500)
        .setLayer(cornerRadius: 15, borderColor: .gray500)
    
    private let questionTableView = OthersAnswerTableView(tableViewType: .recordQuestions)
    
    private lazy var datasource = RecordDiffableDataSource(tableView: self.questionTableView)
    
    init(coordinator: RecordCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setAction()
        applySnapshot(.dummy())
        configureUI(record: .dummy())
    }
    
    func configureUI(record: Record) {
        self.dateFilterButton.setText(text: record.currentDate, font: .body3)
        self.totalCountLabel.text = "총 \(record.questions.count)개"
    }
}

private extension RecordViewController {
    func setDelegate() {
        self.questionTableView.delegate = self
    }
    
    func setAction() {
        let action = UIAction { action in
            self.coordinator.presentSelectMonthPopUpViewController()
        }
        dateFilterButton.addAction(action, for: .touchUpInside)
    }
    
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(totalCountLabel, dateFilterButton, questionTableView)
    }
    
    func setLayout() {
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(29)
            make.leading.equalToSuperview().inset(20)
        }
        
        dateFilterButton.snp.makeConstraints { make in
            make.centerY.equalTo(totalCountLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        questionTableView.snp.makeConstraints { make in
            make.top.equalTo(totalCountLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func applySnapshot(_ records: Record) {
        var snapshot = NSDiffableDataSourceSnapshot<RecordSection, RecordItem>()
        snapshot.appendSections([.question])
        
        let items = records.questions.map { question in
            return RecordItem.question(record: question)
        }
        
        snapshot.appendItems(items, toSection: .question)
        self.datasource.apply(snapshot)
    }
}

extension RecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.showAnswerDetailViewController()
    }
}

