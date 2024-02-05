//
//  AlarmSettingItem.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit

import Carbon
import SnapKit

enum MypageAlarmSwitchType {
    case alarmAccept, alarmReject
}

struct AlarmSettingItem: IdentifiableComponent {
    var isOn: Bool
    var switchTapped: ((MypageAlarmSwitchType)->Void)
    var id: UUID {
        return UUID()
    }
    
    func render(in content: AlarmSettingComponent) {
        content.alarmSwitch.isOn = isOn
        content.switchTapped = switchTapped
    }
    
    func renderContent() -> AlarmSettingComponent {
        .init()
    }
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: bounds.width, height: 62)
    }
}

final class AlarmSettingComponent: UIView {
    var switchTapped: ((MypageAlarmSwitchType)->Void)?
    
    
    private let cellTitle = PLULabel(type: .body1M, color: .black, backgroundColor: .white, text: "알림설정")
    
    let alarmSwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.onTintColor = .designSystem(.black)
        return `switch`
    }()
    
    private let rightArrow = PLUImageView(ImageLiterals.MyPage.arrowRightSmall900)
    
    init() {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.addSubviews(cellTitle, alarmSwitch)
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
                switchTapped?(.alarmReject)
                return
            }
            if !self.alarmSwitch.isOn {
                switchTapped?(.alarmAccept)
            }
        }
    }
}
