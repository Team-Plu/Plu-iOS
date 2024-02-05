//
//  AppversionItem.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit

import Carbon
import SnapKit

struct AppversionItem: IdentifiableComponent {
    var version: String
    var id: String {
        return version
    }
    
    func render(in content: AppversionComponent) {
        content.appVersion.text = version
    }
    
    func renderContent() -> AppversionComponent {
        .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: bounds.width, height: 78)
    }
}

final class AppversionComponent: UIView {
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.font = .suite(.body1M)
        label.text = "앱버전"
        label.textColor = .designSystem(.black)
        return label
    }()
    
    let appVersion: UILabel = {
        let lable = UILabel()
        lable.font = .suite(.body3)
        lable.textColor = .designSystem(.gray300)
        return lable
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.backgroundColor = .designSystem(.white)
    }
    
    func setHierarchy() {
        self.addSubviews(cellTitle, appVersion)
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
