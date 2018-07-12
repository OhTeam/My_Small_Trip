//
//  ReservationViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 17..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class ReservationViewController: UIViewController {
    
    // 상품 이미지, 상품명 Label
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var pk: Int?
    var image: UIImage?
    var text: String?
    
    var url: String?
    
    var reservationInfo: [TravelReservationInfo]?
    var schedules: [Schedule]?
    
    var isFalseSchedules: [String] = []
    var parsingSchedules: [[String]] = []
    
//    var calendarText: String? {
//        didSet {
//            print(calendarText)
////            print(newValue!)
////            self.reloadInputViews()
////            print(newValue!)
//            guard let str = calendarText else { return }
//            print(str)
////            scheduleTextField.text = str
//        }
//    }
    
    // 인원 수 선택
    @IBOutlet var numberOfPeopleTextField: UITextField!
    @IBOutlet var scheduleTextField: UITextField!
    
    var number: [Int] = []
    var maxPeople: Int? {
        willSet {
            for num in 0..<newValue! {
                number.append(num+1)
            }
        }
    }
    
    let pickerView = UIPickerView()
    var pickerSelectRow = 0
    
    
    // 가격
    @IBOutlet private weak var priceLabel: UILabel!
    var price: Int?
    
    
    func shceduleParsing() {
        guard let schedules = schedules else { return }
        for schedule in schedules {
            isFalseSchedules.append(schedule.date)
        }
        //        print(isFalseSchedules)
        self.parsingSchedules = parsingString(isFalseSchedules)
//        print("\n---------- [ parsingSchedules ] -----------\n")
//        print(self.parsingSchedules)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = image
        titleLabel.text = text
        
        let strPrice = String(price!)
        self.priceLabel.text = strPrice.stringChangePrice(strPrice)
        
        fetchCalendarDate()
        
//        print("reserveViewController: viewWillappear")
        print(UserData.user.calendarDate)
        scheduleTextField.text = UserData.user.calendarDate
//        UserData.user.calendarDate = ""
        scheduleTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        scheduleTextField.delegate = self
        
        createToolBar()
    }
    
    // close Button Click Action
    @IBAction private func cancleBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolBar.setItems([done], animated: false)
        
        numberOfPeopleTextField.inputAccessoryView = toolBar
        numberOfPeopleTextField.inputView = pickerView
    }
    
    @objc func donePressed() {
        numberOfPeopleTextField.text = String(number[pickerSelectRow])
        
        let calculatePrice = price! * number[pickerSelectRow]

        let strPrice = String(calculatePrice)
        self.priceLabel.text = strPrice.stringChangePrice(strPrice)
        
        numberOfPeopleTextField.resignFirstResponder()
    }
    
    
    // 날짜 선택 버튼
    func moveSelectDateVC() {
        fetchCalendarDate()
        
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ReservationDatePickViewController") as! ReservationDatePickViewController
        
//        nextVC.numberOfPeople = numberOfPeopleTextField.text
//        nextVC.price = priceLabel.text
//        nextVC.pk = self.pk
//
//        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func moveCalendarVC() {
        let storyBoard = UIStoryboard(name: "Calendar", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
//        guard let parsingSchedule = parsingSchedules else { return }
        print(nextVC.resevationDateArray)
        nextVC.resevationDateArray = self.parsingSchedules
        print(nextVC.resevationDateArray)
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    func fetchCalendarDate() {
        
        guard var url = self.url,
            let people = numberOfPeopleTextField.text,
            let token = UserData.user.token else { return }
        
        url += UrlData.standards.calendar
        let urlParam = ["people": Int(people)!]
        let header: Dictionary<String, String> = ["Authorization": "Token " + token]
        
        
        Alamofire
            .request(url, method: .get, parameters: urlParam, encoding: URLEncoding(destination: .queryString), headers: header)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let json = try JSONDecoder().decode([TravelReservationInfo].self, from: value)
                        self.reservationInfo = json
                        
                        self.schedules = self.reservationInfo![0].schedules
                        self.shceduleParsing()
                        
                    } catch(let error) {
                        print("\n---------- [ JSON Decoder error ] -----------\n")
                        print(error)
                    }
                case .failure(let error):
                    print("\n---------- [ Alamofire request error ] -----------\n")
                    print(error.localizedDescription)
                }
        }
    }
    
    
    @IBAction func reserve() {
        guard let token = UserData.user.token else { return }
        let header = ["Authorization": "Token \(token)"]
        let url = "https://myrealtrip.hongsj.kr/reservation/"
        
        guard let pk = pk,
            let date = scheduleTextField.text,
            let peopleStr = numberOfPeopleTextField.text,
            let people = Int(peopleStr) else { return }
        
        let params: [String:Any] = ["travel_info":pk,
                                    "start_date":date,
                                    "people":people]
        
        Alamofire
            .request(url, method: .post, parameters: params, headers: header)
            .responseJSON(completionHandler: { (response) in
                if let responseValue = response.result.value as! [String:Any]? {
                    print("\n---------- [ 예약완료 ] -----------\n")
                    print(responseValue)
                }
            })
        alert()
    }
    
    func alert() {
        let alertController = UIAlertController(title: "예약 완료", message: "예약이 완료되었습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


// MARK: - UIPickerViewDataSource
extension ReservationViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return number.count
    }
    
}

// MARK: - UIPickerViewDelegate
extension ReservationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(number[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectRow = row
    }
    
}


extension ReservationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == scheduleTextField {
            scheduleTextField.resignFirstResponder()
            
            
            moveCalendarVC()
        }
    }
    
    func monthParsing(_ str: String) -> String {
        //        var string: String!
        let subStr2 = str[str.index(str.startIndex, offsetBy:5)...str.index(str.startIndex, offsetBy:6)]
        let month: String = String(subStr2)
        return month
    }
    
    func dayParsing(_ str: String) -> String {
        //        var string: String!
        let subStr3 = str[str.index(str.startIndex, offsetBy:8)...str.index(str.startIndex, offsetBy:9)]
        let day: String = String(subStr3)
        return day
    }
    
    func parsingString(_ list: [String]) -> [[String]] {
        
        var returnResult: [[String]] = [[],[],[]]
        guard let currentList = list.first else { return returnResult}
        let firstMonth = monthParsing(currentList)
        
        var monthList: [String] = []
        var dayList: [String] = []
        
        
        for str in list {
            monthList.append(monthParsing(str))
            dayList.append(dayParsing(str))
        }
        
        
        for idx in 0..<monthList.count {
            switch Int(monthList[idx]) {
            case Int(firstMonth):
                returnResult[0].append(dayList[idx])
                break
            case Int(firstMonth)!+1:
                returnResult[1].append(dayList[idx])
                break
            case Int(firstMonth)!+2:
                
                if idx == monthList.count-1 {
                    returnResult[2].append(dayList[idx])
                    break
                }
                if monthList[idx] == monthList[idx+1] {
                    returnResult[2].append(dayList[idx])
                    break
                }
            default:
                print("done")
            }
        }
        return returnResult
    }
}
