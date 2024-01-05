//
//  TableViewCellRegisterDequeueProtocol.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import UIKit

protocol TableViewCellRegisterDequeueProtocol {
    static func register(to tableView: UITableView)
    static func dequeueReusableCell(to tableView: UITableView) -> Self
    static var reuseIdentifier: String { get }
}

extension TableViewCellRegisterDequeueProtocol where Self: UITableViewCell {
    static func register(to tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    static func dequeueReusableCell(to tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as? Self else { fatalError("Error! \(self.reuseIdentifier)") }
        return cell
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: TableViewCellRegisterDequeueProtocol {}
