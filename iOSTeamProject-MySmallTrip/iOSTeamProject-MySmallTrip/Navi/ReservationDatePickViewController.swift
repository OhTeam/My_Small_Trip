//
//  ReservationDatePickViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 18..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ReservationDatePickViewController: UIViewController {

    @IBOutlet private weak var dateTf: UITextField!
    var datePicker = UIDatePicker()
    
    var numberOfPeople: String?
    var price: String?
    
    
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

    @objc func doneBtn() {
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        
        let dateString = formatter.string(from: datePicker.date)
        
        dateTf.text = "\(dateString)"
        self.view.endEditing(true)
    }

}

