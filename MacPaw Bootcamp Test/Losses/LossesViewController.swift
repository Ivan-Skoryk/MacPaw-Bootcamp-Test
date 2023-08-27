//
//  LossesViewController.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import UIKit

final class LossesViewController<Formatter: DTOFormatter>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        
        tableView.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "SwitchTableViewCell")
        tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "DatePickerTableViewCell")
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        
        return tableView
    }()
    
    typealias Item = Formatter.T
    var data = [Item]()
    var formatter: Formatter!
    
    private var viewModel: LossesViewModel<Formatter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = LossesViewModel(data: data, formatter: formatter)
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cellData[indexPath.section][indexPath.row] {
        case .switch(let isOn, let onValueChanged):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell") as! SwitchTableViewCell
            cell.config(isOn: isOn)
            cell.isOnColsure = { [weak self] isOn in
                onValueChanged?(isOn)
                self?.tableView.reloadSections(IndexSet(arrayLiteral: 0, 1), with: .fade)
            }
            return cell
        case .datePicker(let name, let minDate, let maxDate, let currentDate, let onDateChanged):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell") as! DatePickerTableViewCell
            cell.config(with: minDate, maxDate: maxDate, currentDate: currentDate, labelText: name)
            cell.onDateChangedClosure = { [weak self] date in
                onDateChanged?(date)
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            }
            
            return cell
        case .data(let name, let count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as! DataTableViewCell
            cell.config(name: name, detail: count)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

