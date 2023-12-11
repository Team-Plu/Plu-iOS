//
//  RecordDiffableDataSource.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/11/23.
//

import UIKit


final class RecordDiffableDataSource: UITableViewDiffableDataSource<RecordSection, RecordItem> {
    
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .question(let question):
                let cell = RecordQuestionTableViewCell.dequeueReusableCell(to: tableView)
                cell.configureCell(question)
                return cell
            }
        }
    }
    
}
