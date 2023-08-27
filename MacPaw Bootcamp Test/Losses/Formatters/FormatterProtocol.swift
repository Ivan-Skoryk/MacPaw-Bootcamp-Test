//
//  FormatterProtocol.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import Foundation

protocol DTOFormatter {
    associatedtype T: Codable
    func formatData(data: [T], for startDate: Date, endDate: Date) -> [Cell]
    func getMinMaxDate(data: [T]) -> (Date, Date)
}
