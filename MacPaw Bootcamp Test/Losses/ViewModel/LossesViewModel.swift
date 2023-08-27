//
//  LossesViewModel.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 25.08.2023.
//

import Foundation

enum Section: Int, CaseIterable {
    case filter = 0
    case data
}

enum Cell {
    case `switch`(isOn: Bool, onValueChanged: ((Bool) -> Void)?)
    case datePicker(name: String, minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil, onDateChanged: ((Date) -> Void)?)
    case data(name: String, count: String)
}

final class LossesViewModel<Formatter: DTOFormatter> {
    typealias Item = Formatter.T
    var sections = Section.allCases
    var cellData = [[Cell]]()
    
    private var isSingleDay = false
    private var dateFrom = Date()
    private var dateTo = Date()
    private var minDate = Date()
    private var maxDate = Date()
    private var dataFormater: Formatter
    private var data: [Item]
    
    init(data: [Item], formatter: Formatter) {
        self.data = data
        dataFormater = formatter
        
        let minMax = dataFormater.getMinMaxDate(data: data)
        minDate = minMax.0
        maxDate = minMax.1
        dateFrom = minDate
        dateTo = maxDate
        
        reloadData()
    }
    
    private func reloadData() {
        cellData = [
            configureFilterSection(),
            configureDataSection()
        ]
    }
    
    private func reloadFilterSection() {
        cellData.remove(at: Section.filter.rawValue)
        cellData.insert(configureFilterSection(), at: Section.filter.rawValue)
    }
    
    private func reloadDataSection() {
        cellData.remove(at: Section.data.rawValue)
        cellData.append(configureDataSection())
    }
    
    private func configureFilterSection() -> [Cell] {
        var section = [Cell]()
        section.append(
            .switch(isOn: isSingleDay, onValueChanged: { [weak self] isOn in
                self?.isSingleDay = isOn
                self?.reloadData()
            })
        )
        
        if isSingleDay {
            section.append(
                .datePicker(name: "Date", minDate: minDate, maxDate: maxDate, currentDate: dateFrom, onDateChanged: { [weak self] date in
                    self?.dateFrom = date
                    self?.reloadDataSection()
                })
            )
        } else {
            section.append(
                .datePicker(name: "Date from", minDate: minDate, maxDate: maxDate, currentDate: dateFrom, onDateChanged: { [weak self] date in
                    self?.dateFrom = date
                    self?.reloadDataSection()
                })
            )
            section.append(
                .datePicker(name: "Date to", minDate: minDate, maxDate: maxDate, currentDate: dateTo, onDateChanged: { [weak self] date in
                    self?.dateTo = date
                    self?.reloadDataSection()
                })
            )
        }
        return section
    }
    
    private func configureDataSection() -> [Cell] {
        return dataFormater.formatData(data: data, for: dateFrom, endDate: isSingleDay ? dateFrom : dateTo)
    }
}
