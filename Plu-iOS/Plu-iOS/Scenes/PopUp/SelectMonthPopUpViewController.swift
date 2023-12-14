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
    
    private let popUpBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.white)
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let yearMonthPicker = UIPickerView()
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .designSystem(.gray600)
        button.setTitleColor(.designSystem(.white), for: .normal)
        button.titleLabel?.font = .suite(.title1)
        return button
    }()
    
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
            make.top.bottom.equalToSuperview().inset(310)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        popUpBackgroundView.addSubviews(yearMonthPicker, agreeButton)
        yearMonthPicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(100)
        }
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(yearMonthPicker.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
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
        let input = SelectMonthPopUpInput(viewWillAppearSubject: viewWillAppearSubject, selectYearAndMonthSubject: selectYearAndMonthSubject, registerButtonTapSubject: registerButtonTapSubject)
        let output = viewModel.transform(input: input)
        output.viewDidLoadPublisher
            .sink { [weak self] in
                self?.yearMonthPicker.selectRow($0.monthRow, inComponent: 1, animated: false)
                self?.yearMonthPicker.selectRow($0.yearRow, inComponent: 0, animated: false)
            }
            .store(in: &cancelBag)
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
