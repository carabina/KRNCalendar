//
//  CalendarCollectionViewController.swift
//  KRNCalendar
//
//  Created by Alexandre Brispot on 06/09/2018.
//  Copyright © 2018 Alexandre Brispot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "dayCell"

open class CalendarCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	private let startYear: Int
	private let endYear: Int
	
	private let calendar = Calendar.current
	
	public init(startYear: Int, endYear: Int) {
		self.startYear = startYear
		self.endYear = endYear
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 4
		layout.headerReferenceSize = CGSize(width: 0, height: 52)
		if #available(iOS 11.0, *) {
			layout.sectionInsetReference = .fromSafeArea
		}
		
		super.init(collectionViewLayout: layout)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    open override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView.backgroundColor = .white
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .always
		}
		collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
		
        collectionView.register(CalendarCollectionViewCell.nib, forCellWithReuseIdentifier: reuseIdentifier)
		collectionView.register(MonthCalendarCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
		
		print(Calendar.current.weekdaySymbols)
    }

    // MARK: UICollectionViewDataSource
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return startYear <= endYear ? (endYear - startYear) * 12 + 12 : 0
    }

    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let firstDayOfMonth = Date(section: section, startYear: startYear)
		
		var prefixDays = firstDayOfMonth.weekday() - Calendar.current.firstWeekday

		if prefixDays == -1 {
			prefixDays += 7
		}
		
		let total = prefixDays + firstDayOfMonth.numberOfDaysInMonth()
		
		return total
	}

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalendarCollectionViewCell

		cell.contentView.layer.borderWidth = 1
		cell.contentView.layer.borderColor = UIColor.red.cgColor
		
		let date = Date(indexPath: indexPath, startYear: startYear)
		
		cell.setWith(date: date)
		
		let sectionMonth = Date(section: indexPath.section, startYear: startYear).month()
		let rowMonth = date.month()
		
		cell.contentView.layer.borderColor = rowMonth == sectionMonth  ? UIColor.blue.cgColor : UIColor.red.cgColor
		
		cell.alpha = rowMonth == sectionMonth  ? 1 : 0.1
		
        return cell
    }
	
	open override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! MonthCalendarCollectionReusableView
			
			header.setWith(date: Date(section: indexPath.section, startYear: startYear))
			
			return header
		} else {
			return UICollectionReusableView()
		}
	}
	
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
