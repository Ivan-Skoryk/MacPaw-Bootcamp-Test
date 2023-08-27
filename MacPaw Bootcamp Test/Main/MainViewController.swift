//
//  MainViewController.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 22.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Main"
        viewModel.navigationController = navigationController
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var title = viewModel.sections[indexPath.row].title
        
        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = MainViewModel.DataType(rawValue: indexPath.row) else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        viewModel.handleSelection(section)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
