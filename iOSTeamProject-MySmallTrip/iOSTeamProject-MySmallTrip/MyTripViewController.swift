//
//  MyTripViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 25..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class MyTripViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var seg: UISegmentedControl!
    
    var myTrips: [MyTrip]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMyTrip()
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        tableView.backgroundColor = UIColor.Custom.backgroundColor
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if seg.selectedSegmentIndex == 0 {
            print("seg 1st")
            fetchMyTrip()
        } else {
            print("seg 2nd")
        }
    }
    
    func fetchMyTrip() {
        guard let token = UserData.user.token else { return }
        let header = ["Authorization": "Token \(token)"]
        let url = UrlData.standards.basic + "/reservation/list/"
        
//        print(url)
        Alamofire
            .request(url, method: .get, headers: header)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    
                    do {
                        self.myTrips = try JSONDecoder().decode([MyTrip].self, from: value)
                        self.tableView.reloadData()
                        
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


extension MyTripViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myTrips = myTrips else { return 0 }
        return myTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTripCell", for: indexPath) as! MyTripCell
        guard let myTrips = myTrips else { return cell }
        cell.myTrip = myTrips[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let myTrips = myTrips else { return 404-44 }
        let text = myTrips[indexPath.row].travel_schedule.travel_info.name
        let textLength = text.lengthOfBytes(using: .utf8)
        
        if textLength > 65 {
            return 404+13-44
        } else {
            return 404-44
        }
    }
}


// MARK: - tableView Cell
class MyTripCell: UITableViewCell {
 
    @IBOutlet private weak var tableViewInCell: UITableView!
    @IBOutlet private weak var headerImageView: UIImageView!
    
    var delegate: UIViewController?
    
    var myTrip: MyTrip? {
        willSet {
            
            let imgUrl = newValue!.travel_schedule.travel_info.main_image
            
            Alamofire
            .request(imgUrl)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    
                    self.headerImageView.image = UIImage(data: value)
                    self.reloadInputViews()
                    
                case .failure(let error):
                    print("\n---------- [ cityImage load fail ] -----------\n")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewInCell.delegate = self
        tableViewInCell.dataSource = self
        
        self.tableViewInCell.estimatedRowHeight = self.tableViewInCell.rowHeight
        self.tableViewInCell.rowHeight = UITableViewAutomaticDimension
        
        if let index = self.tableViewInCell.indexPathForSelectedRow {
            self.tableViewInCell.deselectRow(at: index, animated: true)
        }
    }
}

extension MyTripCell: UITableViewDelegate, UITableViewDataSource {
    
    struct CellName {
        
        static let name = "nameCell"
        
        static let pk = "pkCell"
        static let date = "dateCell"
        static let people = "peopleCell"
        static let price = "priceCell"
        static let cancle = "cancleCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.name, for: indexPath) as! nameCell
            guard let myTrip = myTrip else { return cell }
            cell.nameCell.text = myTrip.travel_schedule.travel_info.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.pk, for: indexPath) as! pkCell
            guard let myTrip = myTrip else { return cell }
            cell.pkLabel.text = String(myTrip.pk)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.date, for: indexPath) as! dateCell
            guard let myTrip = myTrip else { return cell }
            cell.dateLabel.text = myTrip.travel_schedule.start_date
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.people, for: indexPath) as! peopleCell
            guard let myTrip = myTrip else { return cell }
            cell.peopleLabel.text = String(myTrip.people)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.price, for: indexPath) as! priceCell
            guard let myTrip = myTrip else { return cell }
            cell.priceLabel.text = String(myTrip.total_price)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.cancle, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let myTrip = myTrip else { return 44 }
        if indexPath.row == 0 {
            let text = myTrip.travel_schedule.travel_info.name
            let textLength = text.lengthOfBytes(using: .utf8)
            if textLength > 65 {
                return 57
            } else {
                return 44
            }
        } else if indexPath.row == 5 {
            return 20
        }
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
        
//        if indexPath.row == 5 {
//            print("예약취소")
//            let pk = myTrip!.pk
//            cancleReservation(of: pk)
//            cancleAlert()
//
//        }
    }
    
    
    func cancleReservation(of pk: Int) {
        guard let token = UserData.user.token else { return }
        let header = ["Authorization": "Token \(token)"]
        let param = ["pk":pk]
        
        let url = UrlData.standards.basic + "/reservation/cancel/"
        
        Alamofire
        .request(url, method: .patch, parameters: param, headers: header)
            .responseJSON { (response) in
                print(response.response?.statusCode)
                print(response.result.value)
        }
    }
    
    
    func cancleAlert() {
        let vc = ViewController()
        
        let alertController = UIAlertController(title: "예약 취소", message: "예약하신 여행이 취소되었습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        vc.present(alertController, animated: true, completion: nil)
//
//        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
//        let superVC = storyBoard.instantiateViewController(withIdentifier: "MyTripViewController") as! MyTripViewController
//        superVC.present(alertController, animated: true, completion: nil)
//        self.superview?.inputViewController?.present(alertController, animated: true, completion: nil)
    }
    

    
}


// cell of tableViewInCell
// MARK: - MyTripInfoCell

class nameCell: UITableViewCell {
    @IBOutlet var nameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


class pkCell: UITableViewCell {
    
    @IBOutlet var pkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


class dateCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

class peopleCell: UITableViewCell {
    
    @IBOutlet var peopleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

class priceCell: UITableViewCell {
    @IBOutlet var priceLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
