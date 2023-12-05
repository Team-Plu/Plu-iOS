//
//  MyPageRoundSectionHeaderView.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/05.
//

import UIKit

import SnapKit

final class MyPageRoundSectionHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "MyPageRoundSectionHeaderView"
    
    private let roundView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.backgroundColor = .designSystem(.white)
        return view
    }()

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MyPageRoundSectionHeaderView {
    
    func setUI() {
        backgroundColor = .designSystem(.pluRed)
    }
    func setHierarchy() {
        addSubview(roundView)
    }
    
    func setLayout() {
        roundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

