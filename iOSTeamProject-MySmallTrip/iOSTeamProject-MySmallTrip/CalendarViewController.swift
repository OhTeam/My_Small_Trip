//
//  CalendarViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by KimYong Ho on 16/04/2018.
//  Copyright © 2018 ohteam. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var unavailableDateMarkLabel: NSLayoutConstraint!
    @IBOutlet weak var unavailableDateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var topViewOfCalendar: UIView!
    @IBOutlet weak var calendarUITable: UITableView!
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
    
}
//extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CalendarViewController
//        return cell
//    }
//
//
//}


extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
