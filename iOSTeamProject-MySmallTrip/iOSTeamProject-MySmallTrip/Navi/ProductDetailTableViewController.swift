//
//  ProductDetailTableViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class ProductDetailTableViewController: UITableViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var productNumber: UILabel!
    var reservationButton: UIButton!
    
    var productDetail: TravelDetail?
    
    struct StoryBoard {
        static let infoCell = "InfoCell"
        static let photoCell = "PhotoCell"
        static let descriptionCell = "DescriptionCell"
        static let companyCell = "CompanyCell"
        
        static let reservationVC = "ReservationViewController"
    }
    
    var url: String? {
        willSet(newValue) {

            // 이전 페이지에서 받은 url로 데이터 불러오기
            Alamofire
                .request(newValue!, method: .get)
                .responseData { (response) in

                    switch response.result {
                    case .success(let value):
                        do {
                            let productDetailList  = try JSONDecoder().decode([TravelDetail].self, from: value)
                            self.productDetail = productDetailList[0]
                            self.productNumber.text = "상품번호: \(self.productDetail!.pk)"
                            
                            // image insert
                            Alamofire
                                .request(self.productDetail!.images[0].productImg)
                                .responseData { (response) in
                                    
                                    switch response.result {
                                    case .success(let value):
                                        self.imageView.image = UIImage(data: value)
                                        self.tableView.reloadData()
                                    case .failure(let error):
                                        print("\n---------- [ cityImage load fail ] -----------\n")
                                        print(error.localizedDescription)
                                    }
                            }
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView cell height - text length에 따라 맞추기
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // 예약하기 버튼
        makeReserveBtn()
    }
    
    
    // reservation Button layout
    func makeReserveBtn() {
        
        let height: CGFloat = 49
        reservationButton = UIButton(frame: CGRect(x: 0,
                                                   y: self.view.frame.height - height * 2,
                                                   width: self.view.frame.width,
                                                   height: 49))
        
        reservationButton.backgroundColor = UIColor.Custom.mainColor
        reservationButton.alpha = 0.95
        
        reservationButton.setTitle("예약하기", for: .normal)
        reservationButton.setTitleColor(.white, for: .normal)
        
        reservationButton.addTarget(self, action: #selector(moveReserveVC(_:)), for: .touchUpInside)
        
        // TableVC로 생성해서 테이블뷰 위에 위치시키려면 parent.view에 addSubview할 수밖에... ㅠㅜ
        self.parent?.view.addSubview(reservationButton)
        
        // back 누르면 사라지게 해야됨 ㅠ.ㅜ
//        reservationButton.removeFromSuperview()
    }
    
    
    @objc func moveReserveVC(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: StoryBoard.reservationVC) as! ReservationViewController
        
        
        
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    
}




// MARK:  - TableView Delegate, Datasource
extension ProductDetailTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 0 - travel info cell (name, price, ..)
        // 1 - detail description cell
        // 2 - photo cell
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.infoCell, for: indexPath) as! TravelDetailInfoCell
            cell.travel = productDetail
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.descriptionCell, for: indexPath) as! TravelDescriptionCell
            cell.titleLabel.text = productDetail?.description_title
            cell.descriptionLabel.text = productDetail?.description
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.photoCell, for: indexPath)
            return cell
        }
    }
    
}
