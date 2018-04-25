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
    
    // 인원 수 선택
    @IBOutlet private weak var numberOfPeopleTextField: UITextField!
    
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

    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = image
        titleLabel.text = text
        
        priceLabel.text = "₩ " + String(price!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
        priceLabel.text = "₩ " + String(calculatePrice)
        
        numberOfPeopleTextField.resignFirstResponder()
    }
    
    
    // 날짜 선택 버튼
    @IBAction private func moveSelectDateVC() {
        
        // 1)
        // post data
        fetchCalendarDate()
        // send possible date
        
        // 3)
        // move to selectDate(Calendar VC)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ReservationDatePickViewController") as! ReservationDatePickViewController
      
        // 2)
        // 인원 / 가격 정보 넘기기
        nextVC.numberOfPeople = numberOfPeopleTextField.text
        nextVC.price = priceLabel.text
        nextVC.pk = self.pk
        
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    func moveCalendarVC() {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "calendar") // as! Calendar
//        [["18","12"],[],[]]
    
    }
    
    
    func fetchCalendarDate() {
        
        guard var url = self.url,
        let people = numberOfPeopleTextField.text,
        let token = UserData.user.token else { return }
        
        url += UrlData.standards.calendar
        let urlParam = ["people": Int(people)!]
        let header: Dictionary<String, String> = ["Authorization": "Token " + token]
        

        
        print(url, urlParam, header)
        
        Alamofire
            .request(url, method: .get, parameters: urlParam, encoding: URLEncoding(destination: .queryString), headers: header)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let json = try JSONDecoder().decode([TravelReservationInfo].self, from: value)
                        self.reservationInfo = json
                        self.schedules = self.reservationInfo![0].schedules
                        
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
