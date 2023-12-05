//
//  MyPageSeperateSectionHeaderView.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//

import UIKit

import SnapKit

final class MyPageSeperateSectionHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "MyPageSeperateSectionHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MyPageSeperateSectionHeaderView {
    func setUI() {
        backgroundColor = .designSystem(.gray300)
    }
}


