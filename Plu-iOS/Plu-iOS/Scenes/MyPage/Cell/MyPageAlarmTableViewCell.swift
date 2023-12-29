//
//  MyPageAlarmTableViewCell.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//  Copyright (c) 2023 MyPageAlarm. All rights reserved.
//

import UIKit
import Combine

import SnapKit

enum MypageAlarmSwitchType {
    case alarmAccept, alarmReject
}

final class MyPageAlarmTableViewCell: UITableViewCell {
    
    let alarmSwitchTypeSubject = PassthroughSubject<MypageAlarmSwitchType, Never>()
    var cancelBag = Set<AnyCancellable>()

    private let cellTitle = PLULabel(type: .body1M, color: .black)
    
    let alarmSwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.onTintColor = .designSystem(.black)
        return `switch`
    }()
    
    private let rightArrow = PLUImageView(ImageLiterals.MyPage.arrowRightSmall900)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(_ input: MyPageAlarmData) {
        self.alarmSwitch.isOn = input.acceptAlarm
        self.cellTitle.text = input.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cancelBag.removeAll()
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
        alarmSwitch.addTarget(self, action: #selector(onClickSwitch), for: .valueChanged)
    }
    
    @objc func onClickSwitch() {
        let notificationCenter = UNUserNotificationCenter.current()
        Task {
            let setting = await notificationCenter.notificationSettings()
            if setting.authorizationStatus != .authorized {
                self.alarmSwitch.setOn(self.alarmSwitch.isOn, animated: false)
                self.alarmSwitchTypeSubject.send(.alarmReject)
                return
            }
            if !self.alarmSwitch.isOn {
                self.alarmSwitchTypeSubject.send(.alarmAccept)
            }
        }
    }
}
