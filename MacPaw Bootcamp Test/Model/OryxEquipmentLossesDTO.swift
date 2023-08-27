//
//  OryxEquipmentLossesDTO.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import Foundation

struct OryxEquipmentLossesDTO: Codable {
    let equipmentTypeOryx: String
    let model: String
    let manufacturer: String
    let lossesTotal: Int
    let equipmentTypeUA: String
    
    enum CodingKeys: String, CodingKey {
        case model, manufacturer
        case equipmentTypeOryx = "equipment_oryx"
        case lossesTotal = "losses_total"
        case equipmentTypeUA = "equipment_ua"
    }
}
