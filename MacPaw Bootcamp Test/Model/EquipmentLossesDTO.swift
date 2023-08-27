//
//  EquipmentLossesDTO.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import Foundation

struct EquipmentLossesDTO: Codable {
    var date: String
    var day: Int
    var aircraft: Int?
    var helicopter: Int?
    var tank: Int?
    var apc: Int?
    var fieldArtillery: Int?
    var mrl: Int?
    var militaryAuto: Int?
    var fuelTank: Int?
    var drone: Int?
    var navalShip: Int?
    var antiAircraftWarfare: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank, drone

        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
    }
    
    init() {
        self.date = ""
        self.day = 0
        self.aircraft = 0
        self.helicopter = 0
        self.tank = 0
        self.apc = 0
        self.fieldArtillery = 0
        self.mrl = 0
        self.militaryAuto = 0
        self.fuelTank = 0
        self.drone = 0
        self.navalShip = 0
        self.antiAircraftWarfare = 0
    }
}
