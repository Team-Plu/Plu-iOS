//
//  SelectMonthPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit
import Combine

import SnapKit

enum PickerComponentType {
    case year, month
}

final class SelectMonthPopUpViewController: PopUpDimmedViewController {
    
    let viewModel: SelectMonthPopUpViewModel
    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    let selectYearAndMonthSubject = PassthroughSubject<(type: PickerComponentType, row: Int), Never>()
    let registerButtonTapSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    private let popUpBackgroundView = PLUPopUpContainerView()
    private let yearMonthPicker = UIPickerView()
    
//    private lazy var agreeButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("등록하기", for: .normal)
//        button.backgroundColor = .designSystem(.gray600)
//        button.setTitleColor(.designSystem(.white), for: .normal)
//        button.titleLabel?.font = .suite(.title1)
//        return button
//    }()
    
    private lazy var agreeButton = PLUButton(config: .bordered())
        .setText(text: "등록하기", font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .white)
        .setLayer(cornerRadius: 8, borderColor: .gray600)
    
    init(viewModel: SelectMonthPopUpViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        setUp()
        setDelegate()
        bindInput()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearSubject.send(())
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelectMonthPopUpViewController {
    func setUp() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.83)
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        popUpBackgroundView.addSubviews(yearMonthPicker, agreeButton)
        
        agreeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        yearMonthPicker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(agreeButton.snp.top).offset(-20)
        }

    }
    
    func setDelegate() {
        yearMonthPicker.delegate = self
        yearMonthPicker.dataSource = self
    }
    
    func bindInput() {
        agreeButton.tapPublisher
            .sink { [weak self] _ in
                self?.registerButtonTapSubject.send(())
            }
            .store(in: &cancelBag)
    }
    
    func bind() {
        let input = SelectMonthPopUpInput(viewWillAppearSubject: viewWillAppearSubject,
                                          selectYearAndMonthSubject: selectYearAndMonthSubject,
                                          registerButtonTapSubject: registerButtonTapSubject)
        
        let output = viewModel.transform(input: input)
        output.viewDidLoadPublisher
            .sink { [weak self] in
                self?.setPicker(to: self?.yearMonthPicker, monthRow: $0.monthRow, yearRow: $0.yearRow)
            }
            .store(in: &cancelBag)
    }
    
    func setPicker(to target: UIPickerView?, monthRow: Int, yearRow: Int) {
        guard let target else { return }
        target.selectRow(monthRow, inComponent: 1, animated: false)
        target.selectRow(yearRow, inComponent: 0, animated: false)
    }
}

extension SelectMonthPopUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfRowsInComponent(component: component)
    }
}

extension SelectMonthPopUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.titleForRow(component: component, row: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectYearAndMonthSubject.send((type: component == 0 ? .year : .month, row: row))
    }
}
