//
//  MyPageOtherTableViewCell.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//

import UIKit

import SnapKit

final class MyPageOtherTableViewCell: UITableViewCell, TableViewCellRegisterDequeueProtocol {
    
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
        // MARK: - 컴포넌트 설정
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
        // MARK: - button의 addtarget설정
        setAddTarget()
        
        // MARK: - delegate설정
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ input: MypageAppVersionCellData) {
        self.cellTitle.text = input.title
        self.appVersion.text = input.appVersion
    }
}

private extension MyPageOtherTableViewCell {
    func setUI() {
        self.contentView.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.contentView.addSubviews(cellTitle, appVersion)
    }
    
    func setLayout() {
        cellTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        appVersion.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}

