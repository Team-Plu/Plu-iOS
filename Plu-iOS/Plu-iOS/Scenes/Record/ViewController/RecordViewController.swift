//
//  RecordViewController.swift
//  Plu-iOS
//
//  Created by 김민재 on 2023/12/08.
//  Copyright (c) 2023 Record. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class RecordViewController: UIViewController {
    private let viewWillAppear = PassthroughSubject<FilterDate?, Never>()
    private let tableViewCellTapped = PassthroughSubject<Int, Never>()
    private let filterButtonTapped = PassthroughSubject<Void, Never>()
    private let navigationRightButtonTapped = PassthroughSubject<Void, Never>()
    
    private let viewModel: any RecordViewModel
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "일기 기록")
        .setRightButton(type: .logo)
    
    private let totalCountLabel = PLULabel(type: .subHead1, color: .gray600, backgroundColor: .background)
    
    private let dateFilterButton = PLUButton(config: .bordered())
        .setImage(image: ImageLiterals.Respone.arrowDownSmall600, placement: .trailing)
        .setBackForegroundColor(backgroundColor: .background, foregroundColor: .gray500)
        .setLayer(cornerRadius: 15, borderColor: .gray500)
    
    private let questionTableView = OthersAnswerTableView(tableViewType: .recordQuestions)
    
    private lazy var datasource = RecordDiffableDataSource(tableView: self.questionTableView)
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(viewModel: some RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewWillAppear.send(nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        applySnapshot(Record.dummy().questions)
        configureUI(record: .dummy())
        bindInput()
        bind()
    }
    
    func configureUI(record: Record) {
        self.dateFilterButton.setText(text: record.currentDate, font: .body3)
        self.totalCountLabel.text = "총 \(record.questions.count)개"
    }
    
    private func bindInput() {
        navigationBar.rightButtonTapSubject
            .sink { [weak self] _ in
                guard let self else { return }
                self.navigationRightButtonTapped.send(())
            }
            .store(in: &cancelBag)
        
        dateFilterButton.tapPublisher
            .sink { [weak self] _ in
                self?.filterButtonTapped.send(())
            }
            .store(in: &cancelBag)
    }
    
    private func bind() {
        let input = RecordViewModelInput(viewWillAppear: viewWillAppear,
                                         tableViewCellTapped: tableViewCellTapped,
                                         filterButtonTapped: filterButtonTapped,
                                         navigationRightButtonTapped: navigationRightButtonTapped)
        let output = viewModel.transform(input: input)
        output.questions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questions in
                //TODO: 날짜 부분은 서버랑 얘기를 해보고 나서 구현하는게 나을듯?
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MMM d, yyyy"
//                let date = dateFormatter.date(from: "Nov 9, 2023")
//
//                if let date = date {
//                    dateFormatter.dateFormat = "yyyy년 M월"
//                    let resultString = dateFormatter.string(from: date)
//                    print(resultString) // 2023년 9월
//                } else {
//                    print("날짜 변환 실패")
//                }
                self?.applySnapshot(questions)
            }
            .store(in: &cancelBag)
        
    }
}

private extension RecordViewController {
    func setDelegate() {
        self.questionTableView.delegate = self
    }
    
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(totalCountLabel, dateFilterButton,
                              questionTableView, navigationBar)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(29)
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
    
    func applySnapshot(_ questions: [Question]) {
        var snapshot = NSDiffableDataSourceSnapshot<RecordSection, RecordItem>()
        snapshot.appendSections([.question])
        
        let items = questions.map { question in
            return RecordItem.question(record: question)
        }
        
        snapshot.appendItems(items, toSection: .question)
        self.datasource.apply(snapshot)
    }
}

extension RecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewCellTapped.send(indexPath.row)
    }
}
