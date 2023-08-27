//
//  DatePickerTableViewCell.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 24.08.2023.
//

import UIKit

final class DatePickerTableViewCell: UITableViewCell {
    @IBOutlet private weak var intervalLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    var onDateChangedClosure: ((Date)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        intervalLabel.text = nil
        datePicker.minimumDate = nil
        datePicker.maximumDate = nil
        datePicker.date = Date()
    }
    
    func config(with minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date?, labelText: String?) {
        intervalLabel.text = labelText
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.date = currentDate ?? Date()
    }
    
    @IBAction private func onDateChanged(_ sender: UIDatePicker) {
        onDateChangedClosure?(sender.date)
    }
}
