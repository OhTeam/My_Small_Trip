//
//  SearchViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 24..


//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    var statusText: String?
    
    let url = UrlData.standards.basic + UrlData.standards.search
    var productList: [Travel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        

        if productList != nil && productList!.count != 0 {
                self.tableView.register(UINib(nibName: "travelCell", bundle: nil), forCellReuseIdentifier: "travelCell")
                self.tableView.backgroundColor = UIColor.Custom.backgroundColor
        }
        setNaviBackBtn()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if searchBar.text?.count != 0 {
            fetchTravelList(search: searchBar.text!)
        }
    }
}


// MARK: - fetchTravelList
extension SearchViewController {
    
    func fetchTravelList(search: String) {
        guard let token = UserData.user.token else { return }
        let header: Dictionary<String, String> = ["Authorization": "Token " + token]
        
        let searchUrl = url + search
        let param = ["keyword":search]
        
        // convert search String -> query String
        let queryEncodedStr = searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let convertedURL = URL(string: queryEncodedStr)!
//        print(convertedURL)
        
        Alamofire
        .request(convertedURL, method: .get, parameters: param, headers: header)
        .responseData { (response) in
                
                switch response.result {
                case .success(let value):
                    
                    do {
                        self.productList = try JSONDecoder().decode([Travel].self, from: value)
                        
                        // 검색한 여행상품 없을 경우
                        if self.productList?.count == 0 {
                            self.statusText =
                            """
                            아쉽게도 해당 도시의 여행이 없습니다. 😭
                            빠른 시일 내에 추가하겠습니다.
                            """
                        }
                        self.viewDidLoad()
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


// MARK: - TableView Delegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productList?.count == 0 || productList == nil {
            return 1
        } else {
            return productList!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if productList?.count == 0 || productList == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noneSearch", for: indexPath) as! noneSearchCell
            cell.backgroundColor = UIColor.Custom.backgroundColor
            if productList?.count == 0 {
                    cell.statusLabel.text = statusText!
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as! ProductListTableViewCell
            cell.productInfo = self.productList?[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    // tableView Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if productList?.count == 0 || productList == nil {
            return self.tableView.frame.height
        } else {
            // 상품명 text 길이에 따라서 cell height 변동
            let text = self.productList![indexPath.row].name
            let textLength = text.lengthOfBytes(using: .utf8)
            
            if textLength > 65 {
                return 294
            } else {
                return 274
            }
        }
    }
    
    
    // tableView didSelect - cell 선택했을 때, ProductDetailTableViewController로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\n---------- [ SearchVC didSelect Row ] -----------\n")
        
        if productList == nil || productList?.count == 0 {
            print("do not select")
        } else {
            print("\n---------- [ else productList == nil || productList?.count == 0 ] -----------\n")
            let storyBoard = UIStoryboard(name: "Root", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailTableViewController") as! ProductDetailTableViewController
            
            let cityName = productList![indexPath.row].city.name
            let productPk = String(productList![indexPath.row].pk)
            
            // 선택한 도시의 url 전달
            let url = UrlData.standards.basic + UrlData.standards.travelMain
            nextVC.url = url + cityName + "/" + productPk
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}


class noneSearchCell: UITableViewCell {
    @IBOutlet var statusLabel: UILabel!
    
}



