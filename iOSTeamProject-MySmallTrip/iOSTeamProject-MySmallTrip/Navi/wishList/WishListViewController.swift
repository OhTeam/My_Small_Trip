//
//  WishListViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 20..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class WishListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var productList: [Travel] = []
    var url = UrlData.standards.basic + UrlData.standards.travelMain
    
    struct text {
        static let travelCell = "travelCell"
        
        static let storyBoard = "Root"
        static let productDetailVC = "ProductDetailTableViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        fetchWishListData()
        self.tableView.register(UINib(nibName: text.travelCell, bundle: nil), forCellReuseIdentifier: text.travelCell)
        
        setNaviBackBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchWishListData()
    }
    
    
    func fetchWishListData() {
        guard let token = UserData.user.token else { return }
        let header = ["Authorization": "Token \(token)"]
        let url = UrlData.standards.basic + UrlData.standards.wishList
        
        Alamofire
            .request(url, method: .get, headers: header)
            .responseData { (response) in
                
                switch response.result {
                case .success(let value):
                    
                    do {
                        self.productList = try JSONDecoder().decode([Travel].self, from: value)
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


extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if productList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noneSearch", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: text.travelCell, for: indexPath) as! ProductListTableViewCell
            cell.productInfo = self.productList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    // tableView Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if productList.count == 0 {
            return 567
        } else {
            // 상품명 text 길이에 따라서 cell height 변동
            let text = self.productList[indexPath.row].name
            let textLength = text.lengthOfBytes(using: .utf8)
            
            if textLength > 65 {
                return 294
            } else {
                return 274
            }
        }
    }
}


extension WishListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 선택했을 때, ProductDetailTableViewController로 이동
        let storyBoard = UIStoryboard(name: text.storyBoard, bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: text.productDetailVC) as! ProductDetailTableViewController
        
        let cityName = productList[indexPath.row].city.name
        let productPk = String(productList[indexPath.row].pk)
        
        // 선택한 도시의 url 전달
        nextVC.url = self.url + cityName + "/" + productPk
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
