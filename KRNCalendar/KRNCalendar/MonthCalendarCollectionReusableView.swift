//
//  MonthCalendarCollectionReusableView.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

class MonthCalendarCollectionReusableView: UICollectionReusableView {
	@IBOutlet weak var lbl_title: UILabel!
	
	static var nib: UINib {
		return UINib(nibName: "MonthCalendarCollectionReusableView", bundle: Bundle(for: self.self))
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
	}
	
	func setWith(date: Date) {
		lbl_title.text = date.monthName()
	}
}
