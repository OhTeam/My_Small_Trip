//
//  CalendarViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by KimYong Ho on 16/04/2018.
//  Copyright © 2018 ohteam. All rights reserved.
//

import UIKit
import Alamofire



struct ColorOfIsSelected {
    static var red = #colorLiteral(red: 0.9490196078, green: 0.3607843137, blue: 0.3843137255, alpha: 1)

}

//UICollectionViewController

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var resevationDateArray:[[String]] = [[], [], []]
    var currentMonthSelected: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        createUI()
        initializeView()
        
        
//        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }
    
    @IBOutlet weak var unavailableDateMarkLabel: NSLayoutConstraint!
    @IBOutlet weak var unavailableDateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var topViewOfCalendar: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func isSelectedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var applyButton: UIButton!
    @IBAction func applyDateForReservationButton(_ sender: Any) {
        //날짜를 선택하고, 적용 버튼을 누르면 '2018 / 03 / 21' 형식으로 print 할 수 있도록 처리.
        
        //nextVC.
    }
    
    
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
    var secondWeekDayOfMonth = 0
    var thirdWeekDayOfMonth = 0
    
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
        secondWeekDayOfMonth = getsecondWeekDay()
        thirdWeekDayOfMonth = getthirdWeekDay()
        print(firstWeekDayOfMonth)
        
        //윤달 구현
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numberOfDaysInMonth[currentMonthIndex - 1] = 29
        }
        
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
    }
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear) - \(currentMonthIndex) - 01".date?.firstDayofTheMonth.weekday)!
        print("4월: \(day)")
        print(currentYear)
        print(currentMonthIndex)
        return day
    }
    
    //5월의 첫째날
    func getsecondWeekDay() -> Int {
        let day = ("\(currentYear) - \(currentMonthIndex + 1) - 01".date?.firstDayofTheMonth.weekday)!
        print("5월: \(day)")
        return day
    }
    
    //6월의 첫째날
    func getthirdWeekDay() -> Int {
        let day = ("\(currentYear) - \(currentMonthIndex + 2) - 01".date?.firstDayofTheMonth.weekday)!
        print("6월: \(day)")
        return day
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Today", for: indexPath) as! MonthHeaderView
        let data = 4
        let dateString = String(data + indexPath.section)
        header.monthLabel.text = "\(dateString)월"
        if dateString.count == 1 {
            currentMonthSelected = "0\(header.monthLabel.text)"
        } else {
            currentMonthSelected = dateString
        }
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return numberOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
        case 1:
            return numberOfDaysInMonth[currentMonthIndex - 1 + 1 ] + secondWeekDayOfMonth - 1
        default:
            return numberOfDaysInMonth[currentMonthIndex - 1 + 2] + thirdWeekDayOfMonth - 1
        }
//        return numberOfDaysInMonth[currentMonthIndex + section - 1] + firstWeekDayOfMonth - 1
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
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
                    //TODO: Bool값을 받아 false이면 해당 날짜를 회색처리 및 선택 안되게 함
                    //불가능한 날짜 : 서버에서 Bool(false)로 받아와서 선택 안되도록 회색 처리
                    //(현재 날짜 이전은 무조건 선택 안되도록)
                } else {
                    cell.isUserInteractionEnabled = true
                    cell.dateLabel.textColor = UIColor.black
                }
            }
            
            for i in resevationDateArray[indexPath.section] {
                if cell.dateLabel.text == i {
                    cell.dateLabel.textColor = UIColor.lightGray
                    cell.isUserInteractionEnabled = false
                }
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
            cell.backgroundColor = UIColor.clear
            if indexPath.item <= secondWeekDayOfMonth - 2 {
                cell.isHidden = true
            } else {
                let calendarDate = indexPath.row - secondWeekDayOfMonth + 2
                cell.isHidden = false
                cell.dateLabel.text = "\(calendarDate)"
                cell.dateLabel.textColor = UIColor.black
//                if calendarDate < todayDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
//                    cell.isUserInteractionEnabled = false
//                    cell.dateLabel.textColor = UIColor.lightGray
//                    //TODO: Bool값을 받아 false이면 해당 날짜를 회색처리 및 선택 안되게 함
//                    //불가능한 날짜 : 서버에서 Bool(false)로 받아와서 선택 안되도록 회색 처리
//                    //(현재 날짜 이전은 무조건 선택 안되도록)
//                } else {
                    cell.isUserInteractionEnabled = true
//                }
            }
            for i in resevationDateArray[indexPath.section] {
                if cell.dateLabel.text == i {
                    cell.dateLabel.textColor = UIColor.lightGray
                    cell.isUserInteractionEnabled = false
                }
            }
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
            cell.backgroundColor = UIColor.clear
            if indexPath.item <= thirdWeekDayOfMonth - 2 {
                cell.isHidden = true
            } else {
                let calendarDate = indexPath.row - thirdWeekDayOfMonth + 2
                cell.isHidden = false
                cell.dateLabel.text = "\(calendarDate)"
                cell.dateLabel.textColor = UIColor.black
//                if calendarDate < todayDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
//                    cell.isUserInteractionEnabled = false
//                    cell.dateLabel.textColor = UIColor.lightGray
//                    //TODO: Bool값을 받아 false이면 해당 날짜를 회색처리 및 선택 안되게 함
//                    //불가능한 날짜 : 서버에서 Bool(false)로 받아와서 선택 안되도록 회색 처리
//                    //(현재 날짜 이전은 무조건 선택 안되도록)
//                } else {
                    cell.isUserInteractionEnabled = true
//                }
            }
            for i in resevationDateArray[indexPath.section] {
                if cell.dateLabel.text == i {
                    cell.dateLabel.textColor = UIColor.lightGray
                    cell.isUserInteractionEnabled = false
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView)
        switch indexPath.section {
        case 0:
            print(currentMonthSelected)
        case 1:
            print(currentMonthSelected)
        default:
            print(currentMonthSelected)
        }
        
//
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        cell.backgroundColor = ColorOfIsSelected.red
//        if cell?.backgroundColor == ColorOfIsSelected.red {
        print(cell.dateLabel.text)
        print(currentMonthSelected)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
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







