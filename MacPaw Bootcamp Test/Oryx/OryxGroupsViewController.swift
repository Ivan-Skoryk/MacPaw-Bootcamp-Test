//
//  OryxGroupsViewController.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 27.08.2023.
//

import UIKit

final class OryxGroupsViewController: UIViewController {
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        
        return tableView
    }()
    
    var data = [OryxEquipmentLossesDTO]()
    private var viewModel: OryxGroupsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Oryx Groups"
        view.backgroundColor = .systemGroupedBackground
        viewModel = OryxGroupsViewModel(data: data)
        tableView.reloadData()
    }
}

extension OryxGroupsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return viewModel.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            
            cell.textLabel?.text = "Total losses: \(viewModel.cellData.reduce(0, { $0 + $1.totalLosses}))"
            
            return cell
        } else {
            let data = viewModel.cellData[indexPath.row]
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "GroupCell")
            
            cell.textLabel?.text = data.groupType
            cell.detailTextLabel?.text = "Total losses \(data.totalLosses)"
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
    }
}

extension OryxGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let data = viewModel.cellData[indexPath.row]
        
        let vc = OryxDetailsViewController()
        vc.title = data.groupType
        vc.data = data.equip
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
