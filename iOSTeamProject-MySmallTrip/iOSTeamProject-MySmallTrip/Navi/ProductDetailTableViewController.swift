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
    
    @IBOutlet private weak var travelImagesHeaderView: TravelImagesHeaderView!
    var productDetail: TravelDetail?
    
    struct StoryBoard {
        static let showImagesPageViewController = "ShowImagesPageViewController"
        static let infoCell = "InfoCell"
        static let photoCell = "PhotoCell"
        static let descriptionCell = "DescriptionCell"
        static let companyCell = "CompanyCell"
    }
    
    var url: String? {
        willSet(newValue) {

            Alamofire
                .request(newValue!, method: .get)
                .responseData { (response) in

                    switch response.result {
                    case .success(let value):
                        do {
                            let productDetailList  = try JSONDecoder().decode([TravelDetail].self, from: value)
                            self.productDetail = productDetailList[0]
                            
                            print("이게 우선?")
                            self.performSegue(withIdentifier: StoryBoard.showImagesPageViewController, sender: nil)
                            print("됨?")
                            
                            
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
 
    }


    // MARK:  - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == StoryBoard.showImagesPageViewController {
            if let imagePageVC = segue.destination as? TravelImagesPageViewController {
                
                print("이게 언제 호출됨?")
                imagePageVC.images = self.productDetail?.images
                imagePageVC.pageViewControllerDelegate = travelImagesHeaderView
            }
        }
    }
    
}


extension ProductDetailTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 0 - travel info cell (name, price, ..)
        // 1 - photo cell
        // 2 - detail description cell
        // 3 - company info cell
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.infoCell, for: indexPath) as! TravelDetailInfoCell
            cell.travel = productDetail
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.photoCell, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.descriptionCell, for: indexPath) as! TravelDescriptionCell
            cell.descriptionLabel.text = productDetail?.description
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.companyCell, for: indexPath)
            return cell
        }
    }
    
}
