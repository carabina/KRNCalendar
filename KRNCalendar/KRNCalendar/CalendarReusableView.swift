//
//  CalendarReusableView.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

class CalendarReusableView: UICollectionReusableView {
	@IBOutlet weak var lbl_title: UILabel!
	let dateFormatter = DateFormatter()
	
	static var nib: UINib {
		return UINib(nibName: "CalendarReusableView", bundle: Bundle(for: self.self))
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
	}
	
	func setWith(date: Date) {
		if date.year() == Date().year() {
			dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
		} else {
			dateFormatter.setLocalizedDateFormatFromTemplate("MMMMy")
		}
		lbl_title.text = dateFormatter.string(from: date)
	}
}
