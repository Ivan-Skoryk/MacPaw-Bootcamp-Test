//
//  PersonnelLossesPresentationModel.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import Foundation

struct PersonnelLossesPresentationModel {
    enum DataType: Int {
        case personnel = 0
        case pow = 1
        
        var title: String {
            switch self {
            case .personnel: return "Personnel"
            case .pow: return "POW"
            }
        }
    }
    
    var dataType = DataType.personnel
    var detailString = ""
}
