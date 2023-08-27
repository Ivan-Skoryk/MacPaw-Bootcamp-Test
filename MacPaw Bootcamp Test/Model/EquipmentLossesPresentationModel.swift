//
//  EquipmentLossesPresentationModel.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import Foundation

struct EquipmentLossesPresentationModel {
    enum DataType: Int {
        case aircraft = 0
        case helicopter
        case tank
        case apc
        case fieldArtillery
        case mrl
        case militaryAuto
        case fuelTank
        case drone
        case navalShip
        case antiAircraftWarfare
        
        var title: String {
            switch self {
            case .aircraft: return "Aircraft"
            case .helicopter: return "Helicopter"
            case .tank: return "Tank"
            case .apc: return "APC"
            case .fieldArtillery: return "Field Artillery"
            case .mrl: return "MRL"
            case .militaryAuto: return "Military Auto"
            case .fuelTank: return "Fuel Tank"
            case .drone: return "Drone"
            case .navalShip: return "Naval Ship"
            case .antiAircraftWarfare: return "Anti-Aircraft Warfare"
            }
        }
    }
    
    var dataType = DataType.aircraft
    var detailString = ""
}
