//
//  RecordManagerImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation


final class RecordManagerImpl: RecordManager {
    func getRecords() async throws -> [Question] {
        return Record.dummy().questions
    }
    
    func getRecordsByDate(by date: FilterDate) async throws -> [Question] {
        return Record.dummy().questions.filter { question in
            // 일부러 month 저렇게 한거임
            // day랑 Month 헷갈린거 아님
            return question.date == "Nov \(date.month), \(date.year)"
        }
    }
}
