//
//  ViewController.swift
//  KRNCalendarDemo
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit
import KRNCalendar

class ViewController: UIViewController {
	@IBAction func showCalendar() {
		let vc = CalendarViewController(startYear: 2000, endYear: 2020)
		
		navigationController?.pushViewController(vc, animated: true)
	}
}

