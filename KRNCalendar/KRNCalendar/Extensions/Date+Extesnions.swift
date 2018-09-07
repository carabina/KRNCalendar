//
//  Date+Extesnions.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import Foundation

extension Date {
	internal init(section: Int, startYear: Int) {
		var dateComponents = DateComponents()
		
		dateComponents.year = startYear + (section + 1) / 12
		dateComponents.month = (section + 1) % 12
		dateComponents.hour = 0
		dateComponents.minute = 0
		dateComponents.second = 0
		
		let firstDayOfMonth = Calendar.current.date(from: dateComponents)!
		
		self = firstDayOfMonth
	}
	
	internal init(indexPath: IndexPath, startYear: Int) {
		var dateComponents = DateComponents()
		
		dateComponents.year = startYear + (indexPath.section + 1) / 12
		dateComponents.month = (indexPath.section + 1) % 12
		dateComponents.hour = 0
		dateComponents.minute = 0
		dateComponents.second = 0
		
		let firstDayOfMonth = Calendar.current.date(from: dateComponents)!
		
		var prefixDays = firstDayOfMonth.weekday() - Calendar.current.firstWeekday
		
		if prefixDays == -1 {
			prefixDays += 7
		}
		
		let date = firstDayOfMonth.dateByAddingDays(indexPath.row - prefixDays)
		
		self = date
	}
	
	func dateByAddingMonths(_ months : Int ) -> Date {
		let calendar = Calendar.current
		var dateComponent = DateComponents()
		dateComponent.month = months
		return calendar.date(byAdding: dateComponent, to: self)!
	}
	
	func dateByAddingDays(_ days : Int ) -> Date {
		let calendar = Calendar.current
		var dateComponent = DateComponents()
		dateComponent.day = days
		return calendar.date(byAdding: dateComponent, to: self)!
	}
	
	func numberOfDaysInMonth() -> Int {
		return Calendar.current.range(of: .day, in: .month, for: self)!.count
	}
	
	func day() -> Int {
		return Calendar.current.dateComponents([.day], from: self).day!
	}
	
	func weekday() -> Int {
		return Calendar.current.dateComponents([.weekday], from: self).weekday!
	}
	
	func month() -> Int {
		return Calendar.current.dateComponents([.month], from: self).month!
	}
	
	func monthName() -> String {
		let formatter = DateFormatter()
		formatter.setLocalizedDateFormatFromTemplate("MMMM")
		return formatter.string(from: self)
	}
}
