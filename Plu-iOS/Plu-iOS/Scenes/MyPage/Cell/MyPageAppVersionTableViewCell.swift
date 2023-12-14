//
//  MyPageOtherTableViewCell.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//

import UIKit

import SnapKit

final class MyPageAppVersionTableViewCell: UITableViewCell, TableViewCellRegisterDequeueProtocol {
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.font = .suite(.body1M)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    private let appVersion: UILabel = {
        let lable = UILabel()
        lable.font = .suite(.body3)
        lable.textColor = .designSystem(.gray300)
        return lable
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(_ input: MypageAppVersionCellData) {
        self.cellTitle.text = input.title
        self.appVersion.text = input.appVersion
    }
}

private extension MyPageAppVersionTableViewCell {
    func setUI() {
        self.contentView.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.contentView.addSubviews(cellTitle, appVersion)
    }
    
    func setLayout() {
        cellTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        appVersion.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(cellTitle.snp.bottom).offset(2)
        }
    }
}

