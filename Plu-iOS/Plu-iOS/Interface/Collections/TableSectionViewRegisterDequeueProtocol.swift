//
//  TableSectionViewRegisterDequeueProtocol.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/06.
//

import UIKit

protocol TableSectionViewRegisterDequeueProtocol where Self: UITableViewHeaderFooterView {
    static func registerHeaderView(to tableView: UITableView)
    static func dequeueReusableSectionHeaderView(to tableView: UITableView) -> Self
    static var reuseIdentifier: String { get }
}

extension TableSectionViewRegisterDequeueProtocol {
    static func registerHeaderView(to tableView: UITableView) {
        tableView.register(Self.self, forHeaderFooterViewReuseIdentifier: self.reuseIdentifier)
    }
    
    static func dequeueReusableSectionHeaderView(to tableView: UITableView) -> Self {
        guard let sectionHeaderView =
                tableView.dequeueReusableHeaderFooterView(withIdentifier: self.reuseIdentifier) as? Self else { fatalError() }
        return sectionHeaderView
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


