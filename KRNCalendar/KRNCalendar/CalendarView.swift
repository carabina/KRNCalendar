//
//  CalendarView.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 07/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

public protocol CalendarViewDataSource: class {
	func calendarView(_ calendarView: CalendarView, cellForDate date: Date, currentMonth: Bool) -> UICollectionViewCell
	func calendarView(_ calendarView: CalendarView, viewForSupplementaryElementOfKind kind: String, forDate date: Date) -> UICollectionReusableView
}

open class CalendarView: UIView {
	private let startYear: Int
	private let endYear: Int
	
	private var collectionView: UICollectionView
	
	public weak var dataSource: CalendarViewDataSource?
	
	public init(frame: CGRect, startYear: Int, endYear: Int) {
		self.startYear = startYear
		self.endYear = endYear
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 4
		layout.headerReferenceSize = CGSize(width: 0, height: 52)
		if #available(iOS 11.0, *) {
			layout.sectionInsetReference = .fromSafeArea
		}
		
		collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
		collectionView.backgroundColor = .white
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .always
		}
		collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
		
		super.init(frame: frame)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(collectionView)
		
		collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

		collectionView.dataSource = self
		collectionView.register(CalendarViewCell.nib, forCellWithReuseIdentifier: "cell")
		collectionView.register(CalendarReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
		collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
	}
	
	public func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
		collectionView.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	public func dequeueReusableCell(withReuseIdentifier identifier: String, for date: Date) -> UICollectionViewCell {
		return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(item: 0, section: 0))
	}
	
	public func dequeueReusableSupplementaryView(ofKind kind: String, withReuseIdentifier identifier: String, for date: Date) -> UICollectionReusableView {
		return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: IndexPath(item: 0, section: (date.year() - startYear) * 12 + date.month() - 1))
	}
}

extension CalendarView: UICollectionViewDataSource {
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return startYear <= endYear ? (endYear - startYear) * 12 + 12 : 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let firstDayOfMonth = Date(section: section, startYear: startYear)
		
		var prefixDays = firstDayOfMonth.weekday() - Calendar.current.firstWeekday
		
		if prefixDays == -1 {
			prefixDays += 7
		}
		
		let total = prefixDays + firstDayOfMonth.numberOfDaysInMonth()
		
		let suffix = total % 7
		
		return suffix == 0 ? total : total + (7 - suffix)
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let date = Date(indexPath: indexPath, startYear: startYear)
		
		let sectionMonth = Date(section: indexPath.section, startYear: startYear).month()
		let rowMonth = date.month()
		
		guard let customCell = dataSource?.calendarView(self, cellForDate: date, currentMonth: rowMonth == sectionMonth) else {
			let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: date) as! CalendarViewCell
			cell.setWith(date: date)
			return cell
		}

		return customCell
	}
	
	public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let date = Date(section: indexPath.section, startYear: startYear)
		
		guard let customView = dataSource?.calendarView(self, viewForSupplementaryElementOfKind: kind, forDate: date) else {
			if kind == UICollectionView.elementKindSectionHeader {
				let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! CalendarReusableView
				
				header.setWith(date: date)
				
				return header
			} else {
				return UICollectionReusableView()
			}
		}
		
		return customView
	}
}

extension CalendarView: UICollectionViewDelegateFlowLayout	 {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if #available(iOS 11.0, *) {
			let contentWidth = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right - collectionView.contentInset.left - collectionView.contentInset.right
			return CGSize(width: contentWidth / 7, height: contentWidth / 7)
		} else {
			let contentWidth = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
			return CGSize(width: contentWidth / 7, height: contentWidth / 7)
		}
	}
}
