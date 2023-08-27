//
//  OryxGroupsViewModel.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 27.08.2023.
//

import Foundation


struct OryxGroupsViewModel {
    struct OryxGropusCellData {
        let groupType: String
        let equip: [OryxEquipmentLossesDTO]
        
        var totalLosses: Int {
            return equip.reduce(0, { $0 + $1.lossesTotal })
        }
    }
    
    private var data = [OryxEquipmentLossesDTO]()
    var cellData = [OryxGropusCellData]()
    
    init(data: [OryxEquipmentLossesDTO]) {
        self.data = data
        reloadData()
    }
    
    private mutating func reloadData() {
        self.cellData = []
        let types = Set(data.map { $0.equipmentTypeOryx })
        
        types.forEach { type in
            let equipOfType = data.filter { $0.equipmentTypeOryx == type }
            cellData.append(OryxGropusCellData(groupType: type, equip: equipOfType))
        }
        
        cellData.sort(by: { $0.groupType < $1.groupType })
    }
}
