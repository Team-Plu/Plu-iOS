//
//  RecordManager.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation


protocol RecordManager {
    func getRecords() async throws -> [Question]
    func getRecordsByDate(by date: FilterDate) async throws -> [Question]
}
