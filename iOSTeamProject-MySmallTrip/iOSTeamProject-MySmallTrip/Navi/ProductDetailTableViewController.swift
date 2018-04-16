//
//  ProductDetailTableViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController {

    @IBOutlet private weak var travelImagesHeaderView: TravelImagesHeaderView!
    
    var url: String?
    var productList: Travel? {
        willSet(newValue) {
            
            url = String(newValue!.pk)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }


    // MARK:  - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        if segue.identifier == "ShowImagesPageViewController" {
            if let imagePageVC = segue.destination as? TravelImagesPageViewController {
                
                imagePageVC.images = []
                imagePageVC.pageViewControllerDelegate = travelImagesHeaderView
                
            }
        }
        
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
