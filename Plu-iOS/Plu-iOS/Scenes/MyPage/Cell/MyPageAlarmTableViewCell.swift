//
//  MyPageAlarmTableViewCell.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//  Copyright (c) 2023 MyPageAlarm. All rights reserved.
//

import UIKit

import SnapKit

final class MyPageAlarmTableViewCell: UITableViewCell, TableViewCellRegisterDequeueProtocol {
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.font = .suite(.body1M)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    private let alarmSwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.onTintColor = .designSystem(.black)
        return `switch`
    }()
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.MyPage.arrowRightSmall900)
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    func configureUI(_ input: MyPageAlarmCellData) {
        self.alarmSwitch.isOn = input.acceptAlarm
        self.cellTitle.text = input.title
    }
}

private extension MyPageAlarmTableViewCell {
    func setUI() {
        self.contentView.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.contentView.addSubviews(cellTitle, alarmSwitch)
    }
    
    func setLayout() {
        cellTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        alarmSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
