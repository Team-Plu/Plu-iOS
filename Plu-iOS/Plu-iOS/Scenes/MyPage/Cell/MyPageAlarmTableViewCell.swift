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
    case alarmAccept, moveSetting
}

final class MyPageAlarmTableViewCell: UITableViewCell, TableViewCellRegisterDequeueProtocol {
    
    let alarmSwitchTypeSubject = PassthroughSubject<MypageAlarmSwitchType, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.font = .suite(.body1M)
        label.textColor = .designSystem(.black)
        return label
    }()
    
    let alarmSwitch: UISwitch = {
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
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(_ input: MyPageAlarmCellData) {
        self.alarmSwitch.setOn(input.acceptAlarm, animated: false)
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
        if !self.alarmSwitch.isOn {
            self.alarmSwitchTypeSubject.send(.alarmAccept)
        } else {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.getNotificationSettings { settings in
                DispatchQueue.main.async {
                    if settings.authorizationStatus != .authorized {
                        self.alarmSwitchTypeSubject.send(.moveSetting)
                    }
                }
            }
        }
    }
}
