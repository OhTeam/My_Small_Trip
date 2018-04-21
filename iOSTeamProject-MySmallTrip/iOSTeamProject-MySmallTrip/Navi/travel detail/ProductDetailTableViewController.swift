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
    
    private var safeGuide: UILayoutGuide?
    
    @IBOutlet private weak var imageView: UIImageView!
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
                            
                            if let imageUrl = self.productDetail?.images[0].productImg {                                
                                // image insert
                                Alamofire
                                    .request(imageUrl)
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

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.Custom.backgroundColor
        
        // tableView cell height - text length에 따라 맞추기
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // navi bar title - image add / back btn color change
        self.setNaviTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 예약하기 버튼
        makeReserveBtn()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reservationButton.removeFromSuperview()
    }
    
    
    
    // MARK: - Reservation function
    // reservation Button layout
    func makeReserveBtn() {
        let tabBarHeight: CGFloat = 49
        let btnHeight: CGFloat = 45
        reservationButton = UIButton(frame: CGRect(x: 0,
                                                   y: self.view.frame.height - (tabBarHeight + btnHeight),
                                                   width: self.view.frame.width,
                                                   height: btnHeight))
        
        reservationButton.backgroundColor = UIColor.Custom.mainColor
        reservationButton.alpha = 0.95
        reservationButton.setTitle("예약하기", for: .normal)
        reservationButton.setTitleColor(.white, for: .normal)
        reservationButton.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        
        reservationButton.addTarget(self, action: #selector(moveReserveVC(_:)), for: .touchUpInside)
        
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        
        // TableVC로 생성해서 테이블뷰 위에 위치시키려고 parent.view에 addSubview함.
        self.parent?.view.addSubview(reservationButton)
        
        // autoLayout
        safeGuide = self.parent?.view.safeAreaLayoutGuide
        reservationButton.heightAnchor.constraint(equalToConstant: btnHeight).isActive = true

        reservationButton.bottomAnchor.constraint(equalTo: safeGuide!.bottomAnchor).isActive = true
        reservationButton.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor).isActive = true
        reservationButton.trailingAnchor.constraint(equalTo: safeGuide!.trailingAnchor).isActive = true
    }
    
    
    @objc func moveReserveVC(_ sender: UIButton) {
        // 누르면 예약하기 뷰컨트롤러로 이동
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "ReservationNavController") as! UINavigationController
        
        let reservationNavRootVC = popUpVC.childViewControllers[0] as! ReservationViewController
        
        // 현재 상품 이미지, 상품명 전달
        guard let image = self.imageView.image,
            let productName = productDetail?.name,
            let price = productDetail?.price,
            let maxPeople = productDetail?.max_people else { return }
        
            reservationNavRootVC.image = image
            reservationNavRootVC.text = productName
            reservationNavRootVC.price = price
            reservationNavRootVC.maxPeople = maxPeople
            reservationNavRootVC.pk = productDetail?.pk
        
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
