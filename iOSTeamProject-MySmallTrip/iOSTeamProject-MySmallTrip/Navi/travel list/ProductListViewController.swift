//
//  ProductListViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 12..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class ProductListViewController: UIViewController {

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var productListTableView: UITableView!
    
    var productList: [Travel] = []
    
    var url = UrlData.standards.basic + UrlData.standards.travelMain    
    var cityName: String? {
        willSet {
            
            self.url += newValue! + "/"
            
            Alamofire
                .request(url, method: .get)
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let value):
                      
                        do {
                            self.productList = try JSONDecoder().decode([Travel].self, from: value)
                            self.productListTableView.reloadData()
                            
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let cityName = cityName else { return }
        cityNameLabel.text = cityName.removePlusCharacter(of: cityName.uppercased())
        
        // deselect selected UITableView cell
        if let index = self.productListTableView.indexPathForSelectedRow {
            self.productListTableView.deselectRow(at: index, animated: true)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.Custom.backgroundColor
        productListTableView.backgroundColor = UIColor.Custom.backgroundColor
        
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
        // xib file regist
        productListTableView.register(UINib(nibName: "travelCell", bundle: nil), forCellReuseIdentifier: "travelCell")
        
        // navi bar title - image add / back btn color change
        self.setNaviTitle()
        
        // navi bar backBtn title setting
        setNaviBackBtn()
    }
}


// MARK: - TableView Delegate Extension
extension ProductListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as! ProductListTableViewCell
        cell.productInfo = self.productList[indexPath.row]
        cell.selectionStyle = .none
        cell.wishListBtnLayout()
        
        return cell
    }
    
    // tableView Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
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

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cell 선택했을 때, ProductDetailTableViewController로 이동
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailTableViewController") as! ProductDetailTableViewController
        
        // 선택한 도시의 url 전달
        nextVC.url = self.url + String(productList[indexPath.row].pk)
        self.navigationController?.pushViewController(nextVC, animated: true)    
    }
}



