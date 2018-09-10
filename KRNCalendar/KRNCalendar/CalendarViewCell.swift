//
//  CalendarViewCell.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {
	@IBOutlet weak var lbl_day: UILabel!
	
	static var nib: UINib {
		return UINib(nibName: "CalendarViewCell", bundle: Bundle(for: self.self))
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
	}

	func setWith(date: Date) {
		lbl_day.text = date.day().description
		
		lbl_day.textColor = Calendar.current.isDateInWeekend(date) ? .lightGray : .black
	}
}
