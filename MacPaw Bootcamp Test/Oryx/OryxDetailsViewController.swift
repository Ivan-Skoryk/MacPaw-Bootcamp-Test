//
//  OryxDetailsViewController.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 27.08.2023.
//

import UIKit

class OryxDetailsViewController: UIViewController {
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        
        tableView.register(UINib(nibName: "OryxDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "OryxDetailsTableViewCell")
        
        return tableView
    }()
    var data = [OryxEquipmentLossesDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        data.sort(by: { $0.model < $1.model })
        tableView.reloadData()
    }
}

extension OryxDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OryxDetailsTableViewCell", for: indexPath) as! OryxDetailsTableViewCell
        cell.config(with: data.model, manufacturer: data.manufacturer, totalLosses: data.lossesTotal)
        
        return cell
    }
}
