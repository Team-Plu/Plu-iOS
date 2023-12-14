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
    
    var coordinator: OtherAnswersCoordinator
        
    private let everydayAnswerView = PLUEverydayAnswerView()
    
    private let elementImageView = UIImageView()
    
    private let totalAnswerCountLabel = PLULabel(type: .subHead1, color: .gray600, backgroundColor: .background)
    
    private let filterButton = PLUButton(config: .bordered())
        .setImage(image: ImageLiterals.Respone.arrowDownSmall600, placement: .trailing)
        .setBackForegroundColor(backgroundColor: .background, foregroundColor: .gray500)
        .setText(text: AnswerFilterButtonType.latest.title, font: .body3)
        .setLayer(cornerRadius: 15, borderColor: .gray500)
    
    private let menuView = AnswerFilterMenuView()
        
    private let answersTableView = OthersAnswerTableView(tableViewType: .othersAnswers)
    
    private var datasource: UITableViewDiffableDataSource<OtherAnswersSection, OtherAnswersItem>!
    
    init(coordinator: OtherAnswersCoordinator) {
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
        setDataSource()
        configUI(answer: OthersAnswer.dummmy())
        applySnapshot(OthersAnswer.dummmy())
        setButtonHandler()
        setDelegate()
    }
}

private extension OthersAnswerViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(everydayAnswerView, elementImageView,
                              totalAnswerCountLabel, answersTableView, filterButton, menuView)
    }
    
    func setButtonHandler() {
        filterButton.setUpdateHandler(updateHandler: { button in
            var config = button.configuration
            config?.image = button.isSelected
            ? ImageLiterals.Respone.arrowUpSmall600
            : ImageLiterals.Respone.arrowDownSmall600
            button.configuration = config
        })
    }
    
    func setDelegate() {
        self.answersTableView.delegate = self
    }
    
    func setLayout() {
        everydayAnswerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        elementImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(21)
            make.top.equalTo(everydayAnswerView.snp.bottom).offset(28)
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
                
                cell.configureUI(answer, element: element)
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
        self.everydayAnswerView.configureUI(answer: answer)
        self.elementImageView.image = answer.elementType.characterSmallImage
        self.totalAnswerCountLabel.text = "총 \(answer.answers.count)개"
    }
}

extension OthersAnswerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.showAnswerDetailViewController()
    }
}
