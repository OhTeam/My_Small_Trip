//
//  CalendarViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by KimYong Ho on 16/04/2018.
//  Copyright © 2018 ohteam. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        initializeView()
        
    }
    

    
    @IBOutlet weak var unavailableDateMarkLabel: NSLayoutConstraint!
    @IBOutlet weak var unavailableDateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var topViewOfCalendar: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var dayNameUIStackView: UIStackView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    
    var numberOfMonth: [Int] = []
    var numberOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todayDate = 0
    var firstWeekDayOfMonth = 0 //(Sun - Sat 1-7)
    
    func createUI() {
        var dayNamesArr = ["일", "월", "화", "수", "목", "금", "토"]
        for i in 0..<7 {
            let dayNameLabel = UILabel()
            dayNameLabel.text = dayNamesArr[i]
            dayNameLabel.textAlignment = .center
            dayNameLabel.textColor = UIColor.lightGray
            dayNameLabel.backgroundColor = UIColor.white
            
            dayNameUIStackView.layer.borderWidth = 10
            dayNameUIStackView.layer.borderColor = UIColor.lightGray.cgColor
            
            dayNameUIStackView.distribution = .fillEqually
            dayNameUIStackView.addArrangedSubview(dayNameLabel)
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        let result = formatter.string(from: date)
        todayLabel.text = result
    }
    
    func initializeView() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todayDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay() //첫주 날짜 가져오는 함수 구현
        print(firstWeekDayOfMonth)
        
        //윤달 구현
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numberOfDaysInMonth[currentMonthIndex - 1] = 29
        }
        
        presentMonthIndex = currentMonthIndex
//        numberOfMonth = [presentMonthIndex]
        presentYear = currentYear
        
    }
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear) - \(currentMonthIndex) - 01".date?.firstDayofTheMonth.weekday)!
        return day
//        return day == 7 ? 1 : day
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return numberOfMonth.count
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//        <#code#>
//    }

    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Today", for: indexPath) as! MonthHeaderView
//        header.todayButton.setTitle("\(currentYear)년 \(presentMonthIndex)월", for: .normal)
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let result = formatter.string(from: date)
        header.todayButton.setTitle("\(result)", for: .normal)
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInMonth[currentMonthIndex]
//        return numberOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.backgroundColor = UIColor.clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden = true
        } else {
            let calendarDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden = false
            cell.dateLabel.text = "\(calendarDate)"
            if calendarDate < todayDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled = false
                cell.dateLabel.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled = true
//                cell.dateLabel.textColor = Style.activeCellLblColor
            }
        }
        return cell
    }
    
}
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayofTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}



extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}





