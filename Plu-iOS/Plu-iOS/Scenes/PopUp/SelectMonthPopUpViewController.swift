//
//  SelectMonthPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

import SnapKit

final class SelectMonthPopUpViewController: PopUpDimmedViewController {
    
    private let popUpBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.white)
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var monthPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .designSystem(.gray600)
        button.setTitleColor(.designSystem(.white), for: .normal)
        button.titleLabel?.font = .suite(.title1)
        button.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init() {
        super.init()
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func agreeButtonTapped() {
        print("확인버튼 눌림")
    }
    
    @objc func dateChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy 년 MM 월 dd 일(EEEEE)" //데이트 포멧형식 잡기
        formmater.locale = Locale(identifier: "ko_KR") // 한국어 표현
        print(formmater.string(from: datePicker.date))
    }
    
}

private extension SelectMonthPopUpViewController {
    func setUp() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(310)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        popUpBackgroundView.addSubviews(monthPicker, agreeButton)
        monthPicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(100)
        }
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(monthPicker.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
