//
//  PersonelLossesDTOFormatter.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import Foundation


struct PersonelLossesDTOFormatter: DTOFormatter {
    typealias T = PersonnelLossesDTO
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter
    }
    
    func getMinMaxDate(data: [PersonnelLossesDTO]) -> (Date, Date) {
        let minDate = dateFormatter.date(from: data[0].date) ?? Date()
        let maxDate = dateFormatter.date(from: data.last!.date) ?? Date()
        
        return (minDate, maxDate)
    }
    
    func formatData(data: [PersonnelLossesDTO], for startDate: Date, endDate: Date) -> [Cell] {
        let data = filterData(data, from: startDate, to: endDate)
        return data.map {
            .data(name: $0.dataType.title, count: $0.detailString)
        }
    }
    
    private func filterData(_ data: [PersonnelLossesDTO], from: Date, to: Date) -> [PersonnelLossesPresentationModel] {
        var data = data
        data.insert(PersonnelLossesDTO(), at: 0)
        
        let fromString = dateFormatter.string(from: from)
        let firstIndex = data.firstIndex(where: { $0.date == fromString })! - 1
        data.removeFirst(firstIndex)
        
        let toString = dateFormatter.string(from: to)
        if let lastIndex = data.firstIndex(where: { $0.date > toString }) {
            data = Array(data[0..<lastIndex])
        }
        
        var sum = data.last!
        sum.personnel -= data[0].personnel
        sum.pow -= data[0].pow
        
        var presentation = [PersonnelLossesPresentationModel]()
        presentation.append(PersonnelLossesPresentationModel(dataType: .personnel, detailString: "\(sum.personnel ?? 0)"))
        presentation.append(PersonnelLossesPresentationModel(dataType: .pow, detailString: "\(sum.pow ?? 0)"))
        
        return presentation
    }
}
