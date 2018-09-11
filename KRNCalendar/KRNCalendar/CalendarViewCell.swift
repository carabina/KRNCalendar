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
	
	private var date: Date?
	override var isSelected: Bool {
		didSet {
			if let date = date {
				setWith(date: date)
			}
		}
	}
	override var isHighlighted: Bool {
		didSet {
			if let date = date {
				setWith(date: date)
			}
		}
	}
	
	static var nib: UINib {
		return UINib(nibName: "CalendarViewCell", bundle: Bundle(for: self.self))
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
	}
	
	func setWith(date: Date) {
		self.date = date
		lbl_day.text = date.day().description
		
		if isSelected {
			lbl_day.textColor = .white
			lbl_day.backgroundColor = Calendar.current.isDateInWeekend(date) ? .lightGray : .darkGray
		} else {
			lbl_day.textColor = Calendar.current.isDateInWeekend(date) ? .lightGray : .black
			lbl_day.backgroundColor = .white
		}
	}
}
