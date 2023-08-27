//
//  MainViewModel.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import Foundation
import UIKit

struct MainViewModel {
    enum DataType: Int, CaseIterable {
        case equipLosses = 0
        case personnelLosses
        case oryxData
        
        var title: String {
            switch self {
            case .equipLosses: return "Equipment Losses"
            case .personnelLosses: return "Personnel Losses"
            case .oryxData: return "Equipment Losses (by Oryx)"
            }
        }
    }
    
    var sections = DataType.allCases
    weak var navigationController: UINavigationController?
    
    typealias DataProvider = PersonelLossesDataProvider & EquipmentLossesDataProvider & OryxEquipmentLossesDataProvider
    private let dataProvider: any DataProvider
    
    init() {
        self.dataProvider = JSONReaderService()
    }
    
    func handleSelection(_ section: DataType) {
        switch section {
        case .personnelLosses:
            dataProvider.getPersonnelLosses { result in
                switch result {
                case .success(let data):
                    let sorted = data.sorted(by: { $0.date < $1.date })
                    toLossessViewController(with: sorted)
                case .failure(let error):
                    handleError(error)
                    break
                }
            }
        case .equipLosses:
            dataProvider.getEquipmentLosses { result in
                switch result {
                case .success(let data):
                    let sorted = data.sorted(by: { $0.date < $1.date })
                    toLossessViewController(with: sorted)
                case .failure(let error):
                    handleError(error)
                    break
                }
            }
        case .oryxData:
            dataProvider.getOryxEquipmentLosses { result in
                switch result {
                case .success(let data):
                    let vc = OryxGroupsViewController()
                    vc.data = data
                    navigationController?.pushViewController(vc, animated: true)
                case .failure(let error):
                    handleError(error)
                    break
                }
            }
        }
    }
    
    func toLossessViewController(with data: [PersonnelLossesDTO]) {
        DispatchQueue.main.async {
            let vc = LossesViewController<PersonelLossesDTOFormatter>()
            vc.data = data
            vc.formatter = PersonelLossesDTOFormatter()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func toLossessViewController(with data: [EquipmentLossesDTO]) {
        DispatchQueue.main.async {
            let vc = LossesViewController<EquipmentLossesDTOFormatter>()
            vc.data = data
            vc.formatter = EquipmentLossesDTOFormatter()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func handleError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
