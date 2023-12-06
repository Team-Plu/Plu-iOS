//
//  OthersAnswerViewController.swift
//  Plu-iOS
//
//  Created by 김민재 on 2023/12/04.
//  Copyright (c) 2023 OthersAnswer. All rights reserved.
//

import UIKit

import SnapKit

final class OthersAnswerViewController: UIViewController {
    
    private let dateLabel = PLULabel(type: .body2R, color: .gray500, backgroundColor: .background)
    private let questionLabel = PLULabel(type: .head1, color: .gray800,
                                         backgroundColor: .background,
                                         alignment: .center, lines: 2)
    
    private let elementImageView = UIImageView()
    
    private let totalAnswerCountLabel = PLULabel(type: .subHead1, color: .gray600, backgroundColor: .background)
    
    private let filterButton = AnswerFilterButton(buttonType: .latest)
    private let menuView = AnswerFilterMenuView()
        
    private var datasource: UITableViewDiffableDataSource<OtherAnswersSection, OtherAnswersItem>!
    
    private let answersTableView = OthersAnswerTableView()
    
//    private let answerView = AnswerView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDataSource()
        configUI(answer: OthersAnswer.dummmy())
        applySnapshot(OthersAnswer.dummmy())
    }
}

private extension OthersAnswerViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(dateLabel, questionLabel, elementImageView,
                              totalAnswerCountLabel, answersTableView, filterButton, menuView)
    }
    
    func setLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.centerX.equalTo(dateLabel)
        }
        
        elementImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(21)
            make.top.equalTo(questionLabel.snp.bottom).offset(28)
        }
        
        totalAnswerCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(elementImageView.snp.trailing).offset(4)
            make.centerY.equalTo(elementImageView)
        }
        
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(totalAnswerCountLabel)
            make.trailing.equalToSuperview().inset(21)
        }
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom).offset(6)
            make.centerX.equalTo(filterButton)
            make.leading.trailing.equalTo(filterButton).inset(6)
        }
        
        answersTableView.snp.makeConstraints { make in
            make.top.equalTo(elementImageView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setDataSource() {
        self.datasource = .init(tableView: answersTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .answer(let answer, let element):
                let cell = AnswerTableViewCell.dequeueReusableCell(to: self.answersTableView)
                
                cell.configureView(answer, element: element)
                return cell
            }
        })
    }
    
    func applySnapshot(_ othersAnswers: OthersAnswer) {
        var snapshot = NSDiffableDataSourceSnapshot<OtherAnswersSection, OtherAnswersItem>()
        
        snapshot.appendSections([.answer])
        let items = othersAnswers.answers.map { answer in
            return OtherAnswersItem.answer(answer: answer, element: othersAnswers.elementType)
        }
        snapshot.appendItems(items, toSection: .answer)
        self.datasource.apply(snapshot)
    }
    
    func configUI(answer: OthersAnswer) {
        self.dateLabel.text = answer.date
        self.questionLabel.text = answer.question
        self.elementImageView.image = answer.elementType.characterSmallImage
        self.totalAnswerCountLabel.text = "총 \(answer.answersCount)개"
    }
}
