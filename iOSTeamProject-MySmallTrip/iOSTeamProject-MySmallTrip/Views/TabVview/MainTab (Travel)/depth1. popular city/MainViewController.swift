//
//  MainViewController.swift
//  MySmallTrip
//
//  Created by sungnni on 2018. 4. 5..
//  Copyright © 2018년 OhTeam. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet private weak var popularCityTableView: UITableView!
    var cities: [PopularCity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        
        // 코드로 변경해 줘야 스크롤 바운스 할 때도 지정한 배경컬러로 나옴.
        // 스토리보드로 변경하면 소용 무. 로드되는 시점차이 때문인 것 같긴한데 정확한 이유는 모르겠음..
        popularCityTableView.backgroundColor = UIColor.Custom.backgroundColor
        
        fetchCityData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // deselect selected UITableView cell
        if let index = self.popularCityTableView.indexPathForSelectedRow {
            self.popularCityTableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    
    private func fetchCityData() {
        let url = UrlData.standards.basic + UrlData.standards.travelMain
        
        Alamofire.request(url, method: .get)
            .responseData { (response) in
                
                switch response.result {
                case .success(let value):

                    do {
                        self.cities = try JSONDecoder().decode([PopularCity].self, from: value)                        
                        self.popularCityTableView.reloadData()
                        
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

// MARK: - TableView Delegate Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PopularCityTableViewCell
        cell.cityInfo = self.cities[indexPath.row]
        return cell
    }
    
    // tableView Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    
    // didSelect Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cell 선택했을 때, 선택한 도시의 여행 상품을 보여주는 뷰(ProductListViewController)로 이동
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        
        // 선택한 도시 이름 next VC에 전달 (url 용도)
        nextVC.cityName = cities[indexPath.row].name
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

