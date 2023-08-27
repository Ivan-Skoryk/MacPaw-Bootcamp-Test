//
//  EquipmentLossesDTOFormatter.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import Foundation

struct EquipmentLossesDTOFormatter: DTOFormatter {
    typealias T = EquipmentLossesDTO
    
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter
    }
    
    func formatData(data: [EquipmentLossesDTO], for startDate: Date, endDate: Date) -> [Cell] {
        let data = filterData(data, from: startDate, to: endDate)
        return data.map {
            .data(name: $0.dataType.title, count: $0.detailString)
        }
    }
    
    func getMinMaxDate(data: [EquipmentLossesDTO]) -> (Date, Date) {
        let minDate = dateFormatter.date(from: data[0].date) ?? Date()
        let maxDate = dateFormatter.date(from: data.last!.date) ?? Date()
        
        return (minDate, maxDate)
    }
    
    private func filterData(_ data: [EquipmentLossesDTO], from: Date, to: Date) -> [EquipmentLossesPresentationModel] {
        var data = data
        data.insert(EquipmentLossesDTO(), at: 0)
        
        let fromString = dateFormatter.string(from: from)
        let firstIndex = data.firstIndex(where: { $0.date == fromString })! - 1
        data.removeFirst(firstIndex)
        
        let toString = dateFormatter.string(from: to)
        if let lastIndex = data.firstIndex(where: { $0.date > toString }) {
            data = Array(data[0..<lastIndex])
        }
        
        var sum = data.last!
        sum.aircraft -= data[0].aircraft
        sum.helicopter -= data[0].helicopter
        sum.tank -= data[0].tank
        sum.apc -= data[0].apc
        sum.fieldArtillery -= data[0].fieldArtillery
        sum.mrl -= data[0].mrl
        sum.militaryAuto -= data[0].militaryAuto
        sum.fuelTank -= data[0].fuelTank
        sum.drone -= data[0].drone
        sum.navalShip -= data[0].navalShip
        sum.antiAircraftWarfare -= data[0].antiAircraftWarfare
        
        var presentation = [EquipmentLossesPresentationModel]()
        presentation.append(
            contentsOf:
                [
                    EquipmentLossesPresentationModel(
                        dataType: .aircraft,
                        detailString: "\(sum.aircraft ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .helicopter,
                        detailString: "\(sum.helicopter ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .tank,
                        detailString: "\(sum.tank ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .apc,
                        detailString: "\(sum.apc ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .fieldArtillery,
                        detailString: "\(sum.fieldArtillery ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .mrl,
                        detailString: "\(sum.mrl ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .militaryAuto,
                        detailString: "\(sum.militaryAuto ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .fuelTank,
                        detailString: "\(sum.fuelTank ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .drone,
                        detailString: "\(sum.drone ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .navalShip,
                        detailString: "\(sum.navalShip ?? 0)"
                    ),
                    EquipmentLossesPresentationModel(
                        dataType: .antiAircraftWarfare,
                        detailString: "\(sum.antiAircraftWarfare ?? 0)"
                    ),
                ]
        )
        
        return presentation
    }
}
