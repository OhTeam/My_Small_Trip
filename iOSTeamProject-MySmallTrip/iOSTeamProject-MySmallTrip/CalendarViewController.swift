//
//  CalendarViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by KimYong Ho on 16/04/2018.
//  Copyright © 2018 ohteam. All rights reserved.
//

import UIKit
protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year: Int)
}


class CalendarViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, MonthViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeView()
        createUI()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendarCollectionView.collectionViewLayout.invalidateLayout()

    }


    @IBOutlet weak var unavailableDateMarkLabel: NSLayoutConstraint!
    @IBOutlet weak var unavailableDateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var topViewOfCalendar: UIView!
//    @IBOutlet weak var calendarUITable: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var dayNameUIStackView: UIStackView!
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    
    
    func createUI() {
        var dayNamesArr = ["일", "월", "화", "수", "목", "금", "토"]
        for i in 0..<7 {
            let dayNameLabel = UILabel()
            dayNameLabel.text = dayNamesArr[i]
            dayNameLabel.textAlignment = .center
            dayNameLabel.textColor = UIColor.gray
            dayNameLabel.backgroundColor = UIColor.white
            
            dayNameUIStackView.distribution = .fillEqually
//            dayNameUIStackView.backgroundColor = UIColor.white
            
            dayNameUIStackView.addArrangedSubview(dayNameLabel)
        }
    }
    
    var numberOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var presentMonthIndex = 0
    var presentYaer = 0
    var todayDate = 0
    var firstWeekDayOfMonth = 0 //(Sun - Sat 1-7)
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! dateCell
//        cell.backgroundColor = UIColor.clear
//        if indexPath.item <= firstWeekDayOfMonth - 2 {
//            cell.isHidden = true
//        } else {
//            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
//            cell.isHidden = false
//            cell.dateLabel.text = "\(calcDate)"
//            if calcDate < todayDate && currentYear == presentYaer && currentMonthIndex == presentMonthIndex {
//                cell.isUserInteractionEnabled = false
//                cell.dateLabel.textColor = UIColor.lightGray
//            } else {
//                cell.isUserInteractionEnabled = true
//                cell.dateLabel.textColor = UIColor.black
//            }
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    func initializeView() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todayDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        //윤달
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numberOfDaysInMonth[currentMonthIndex - 1] == 29
        }
        presentMonthIndex = currentMonthIndex
        presentYaer = currentYear
        
        //반복되는 뷰를 호출해줘야 함
        //Cell 등록은 스토리보드에서 함
    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear) - \(currentMonthIndex) - 01".date?.firstDayofMonth.weekday)!
        return day
        //return day == 7 ? 1 : day
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        //2월 윤달은 29일
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numberOfDaysInMonth[monthIndex] = 29
            } else {
                numberOfDaysInMonth[monthIndex] = 28
            }
        }
        firstWeekDayOfMonth = getFirstWeekDay()
    }
}

class dateCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setupViews()
    }
    func setupViews() {
        addSubview(dateLabel)
    }
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Get first day of the month
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayofMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
}

//MARK: - Get date from string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

//MARK: - CaledarView TableView
//extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//}
