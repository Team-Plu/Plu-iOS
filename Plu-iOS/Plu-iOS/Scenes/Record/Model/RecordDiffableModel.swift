//
//  RecordDiffableModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/8/23.
//

import Foundation


enum RecordSection {
    case question
}

enum RecordItem: Hashable {
    case question(record: Question)
}
