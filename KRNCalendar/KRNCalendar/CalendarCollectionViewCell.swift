//
//  CalendarCollectionViewCell.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var lbl_day: UILabel!
	@IBOutlet weak var lbl_debugDate: UILabel!

	private let dateFormatter = DateFormatter()
	
	static var nib: UINib {
		return UINib(nibName: "CalendarCollectionViewCell", bundle: Bundle(for: self.self))
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		dateFormatter.setLocalizedDateFormatFromTemplate("dMyy")
    }

	func setWith(date: Date) {
		lbl_day.text = date.day().description
		lbl_debugDate.text = dateFormatter.string(from: date)
		
		lbl_day.textColor = Calendar.current.isDateInWeekend(date) ? .lightGray : .black
	}
}
