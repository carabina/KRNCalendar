//
//  CalendarViewController.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 10/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "day"

open class CalendarViewController: UIViewController, CalendarViewDataSource {
	open var calendarView: CalendarView
	
	public init(startYear: Int, endYear: Int) {
		calendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), startYear: startYear, endYear: endYear)
		super.init(nibName: nil, bundle: nil)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override open func viewDidLoad() {
        super.viewDidLoad()
		
		calendarView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(calendarView)
		calendarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

		calendarView.dataSource = self
		
		calendarView.register(CalendarViewCell.nib, forCellWithReuseIdentifier: reuseIdentifier)
		
		calendarView.preservesSuperviewLayoutMargins = true
	}
	
	public func calendarView(_ calendarView: CalendarView, cellForDate date: Date, currentMonth: Bool) -> UICollectionViewCell {
		let cell = calendarView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: date) as! CalendarViewCell
		cell.setWith(date: date)
		
		cell.contentView.alpha = currentMonth ? 1 : 0.1
		
		return cell
	}
	
	public func calendarView(_ calendarView: CalendarView, viewForSupplementaryElementOfKind kind: String, forDate date: Date) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let header = calendarView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: date) as! CalendarReusableView
			
			header.setWith(date: date)
			
			return header
		} else {
			return UICollectionReusableView()
		}
	}
}
