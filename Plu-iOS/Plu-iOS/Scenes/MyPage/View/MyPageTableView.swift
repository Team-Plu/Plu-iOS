//
//  MyPageTableView.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import UIKit

protocol MyPageHeaderDelgate: AnyObject {
    func headerDidTapped()
}

final class MyPageTableView: UITableView {
    
    weak var myPageHeaderDelgate: MyPageHeaderDelgate?
    
    private let headerView = MyPageHeaderView()

    init() {
        super.init(frame: .zero, style: .grouped)
        setTableView()
        registerCell()
        registerSectionHeader()
        setHeader()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        headerView.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableHeader(nickName: String) {
        self.headerView.configure(nickName)
    }
    
    @objc func viewTapped() {
        self.myPageHeaderDelgate?.headerDidTapped()
    }
}

private extension MyPageTableView {
    func setTableView() {
        self.separatorStyle = .none
        self.sectionFooterHeight = 0
        self.backgroundColor = .designSystem(.background)
    }
    
    func registerCell() {
        MyPageAlarmTableViewCell.register(to: self)
        MyPageGeneralTableViewCell.register(to: self)
        MyPageAppVersionTableViewCell.register(to: self)
    }
    
    func registerSectionHeader() {
        MyPageRoundSectionHeaderView.registerHeaderView(to: self)
    }
    
    func setHeader() {
        self.tableHeaderView = headerView
    }
}
