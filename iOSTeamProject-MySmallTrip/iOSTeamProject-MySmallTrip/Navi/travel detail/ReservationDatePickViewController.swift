//
//  ReservationDatePickViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 18..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class ReservationDatePickViewController: UIViewController {

    @IBOutlet private weak var dateTf: UITextField!
    var datePicker = UIDatePicker()
    
    var numberOfPeople: String?
    var price: String?
    var pk: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createToolBar()
    }
    
    func createToolBar() {
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtn))
        
        toolBar.setItems([barButtonItem], animated: false)
        
        dateTf.inputAccessoryView = toolBar
        dateTf.inputView = datePicker
        
    }

    var date: Date?
    @objc func doneBtn() {
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: datePicker.date)
        print(dateString)

        self.date = formatter.date(from: dateString)
        
        dateTf.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    @IBAction private func reserveAction() {
        guard let token = UserData.user.token else { return }
        let header: Dictionary<String, String> = ["Authorization": "Token " + token]
        let params: [String:Any] = ["travel_info":pk!,
                                    "start_date":dateTf.text!,
                                    "people":Int(numberOfPeople!)!]
        print(params)
        let url = "https://myrealtrip.hongsj.kr/reservation/"
        
        Alamofire
            .request(url, method: .post, parameters: params, headers: header)
            .responseJSON { (response) in
                if let responseValue = response.result.value as! [String:Any]? {
                    print(responseValue)
                }
        }
    }

}

