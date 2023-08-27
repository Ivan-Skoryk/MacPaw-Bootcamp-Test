//
//  PersonnelLossesDTO.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import Foundation

struct PersonnelLossesDTO: Codable {
    var date: String
    var day: Int?
    var personnel: Int?
    var pow: Int?
    
    init() {
        self.date = ""
        self.day = 0
        self.personnel = 0
        self.pow = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case personnel
        case pow = "POW"
    }
}
