//
//  SwitchTableViewCell.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import UIKit

final class SwitchTableViewCell: UITableViewCell {
    @IBOutlet private weak var isSingleDaySwitch: UISwitch!
    var isOnColsure: ((Bool)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSingleDaySwitch.isOn = false
    }
    
    func config(isOn: Bool) {
        isSingleDaySwitch.setOn(isOn, animated: true)
    }
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        isOnColsure?(sender.isOn)
    }
}
