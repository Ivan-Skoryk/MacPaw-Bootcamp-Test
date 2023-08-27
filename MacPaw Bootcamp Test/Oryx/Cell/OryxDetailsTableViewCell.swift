//
//  OryxDetailsTableViewCell.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 27.08.2023.
//

import UIKit

class OryxDetailsTableViewCell: UITableViewCell {
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var manufacturerLabel: UILabel!
    @IBOutlet private weak var totalLosses: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        modelLabel.text = ""
        manufacturerLabel.text = ""
        totalLosses.text = ""
    }
    
    func config(with model: String, manufacturer: String, totalLosses: Int) {
        modelLabel.text = model
        manufacturerLabel.text = manufacturer
        self.totalLosses.text = "Total losses: \(totalLosses)"
    }
}
