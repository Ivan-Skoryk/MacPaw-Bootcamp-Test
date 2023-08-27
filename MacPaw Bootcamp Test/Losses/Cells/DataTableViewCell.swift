//
//  DataTableViewCell.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import UIKit

final class DataTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        detailLabel.text = ""
    }
    
    func config(name: String, detail: String) {
        nameLabel.text = name
        detailLabel.text = detail
    }
}
