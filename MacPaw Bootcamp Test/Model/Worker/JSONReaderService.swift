//
//  JSONReaderService.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import Foundation

protocol EquipmentLossesDataProvider {
    func getEquipmentLosses(completion: @escaping ((Result<[EquipmentLossesDTO], any Error>) -> Void))
}

protocol PersonelLossesDataProvider {
    func getPersonnelLosses(completion: @escaping ((Result<[PersonnelLossesDTO], any Error>) -> Void))
}

protocol OryxEquipmentLossesDataProvider {
    func getOryxEquipmentLosses(completion: @escaping ((Result<[OryxEquipmentLossesDTO], any Error>) -> Void))
}

class JSONReaderService: EquipmentLossesDataProvider, PersonelLossesDataProvider, OryxEquipmentLossesDataProvider {
    enum JSONReaderError: Error {
        case noFile
        case wrongFormat
    }
    
    func getEquipmentLosses(completion: @escaping ((Result<[EquipmentLossesDTO], any Error>) -> Void)) {
        var data = getArray(
            of: EquipmentLossesDTO.self,
            filename: "russia_losses_equipment",
            completion: nil
        )
        
        let correctionData = getArray(
            of: EquipmentLossesDTO.self,
            filename: "russia_losses_equipment_correction",
            completion: nil
        )
        
        for elem in correctionData {
            if let firstIndex = data.firstIndex(where: { $0.date == elem.date }) {
                data[firstIndex].aircraft += elem.aircraft
                data[firstIndex].helicopter += elem.helicopter
                data[firstIndex].tank += elem.tank
                data[firstIndex].apc += elem.apc
                data[firstIndex].fieldArtillery += elem.fieldArtillery
                data[firstIndex].mrl += elem.mrl
                data[firstIndex].militaryAuto += elem.militaryAuto
                data[firstIndex].fuelTank += elem.fuelTank
                data[firstIndex].drone += elem.drone
                data[firstIndex].navalShip += elem.navalShip
                data[firstIndex].antiAircraftWarfare += elem.antiAircraftWarfare
            }
        }
        
        completion(.success(data))
    }
    
    func getPersonnelLosses(completion: @escaping ((Result<[PersonnelLossesDTO], any Error>) -> Void)) {
        var data = getArray(
            of: PersonnelLossesDTO.self,
            filename: "russia_losses_personnel",
            completion: nil
        )
        
        if let firstIndex = data.firstIndex(where: { $0.pow == nil }) {
            let pow = data[firstIndex-1].pow ?? 0
            for i in firstIndex..<data.endIndex {
                data[i].pow = pow
            }
        }
        completion(.success(data))
    }
    
    func getOryxEquipmentLosses(completion: @escaping ((Result<[OryxEquipmentLossesDTO], any Error>) -> Void)) {
        getArray(
            of: OryxEquipmentLossesDTO.self,
            filename: "russia_losses_equipment_oryx",
            completion: completion
        )
    }
    
    @discardableResult
    func getArray<T: Decodable>(of type: T.Type, filename: String, completion: ((Result<[T], any Error>) -> ())?) -> [T] {
        guard let urlString = Bundle.main.path(forResource: filename, ofType: "json"),
              let data = try? Data(contentsOf: URL(filePath: urlString)) else {
                completion?(.failure(JSONReaderError.noFile))
            return []
        }
        
        do {
            let array = try JSONDecoder().decode([T].self, from: data)
            completion?(.success(array))
            return array
        } catch let error {
            print("decode error occured, \(error.localizedDescription)")
            completion?(.failure(JSONReaderError.wrongFormat))
            return []
        }
    }
}
