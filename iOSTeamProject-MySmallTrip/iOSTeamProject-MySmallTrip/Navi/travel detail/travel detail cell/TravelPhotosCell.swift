//
//  TravelPhotosCell.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 22..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class TravelPhotosCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var images: [TravelImage] = [] {
        willSet {
//            print(newValue[0].productImg)
//            print(newValue.count)
            
            self.collectionView.reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print(collectionView.frame.size.height)
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


// MARK: - UICollectionViewDataSource
extension TravelPhotosCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotosCollectionViewCell
        cell.backgroundColor = UIColor.black
        
        if self.images.count != 0 {
            print("reload")
            cell.image = images[indexPath.item].productImg
        }
//        print("reload2")
        return cell
    }
    
    
}




// MARK: - UICollectionViewDelegate
extension TravelPhotosCell: UICollectionViewDelegate {
    
}



// MARK: - Photos CollectionView Cell
class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: String? {
        willSet(imgUrl) {
            print(imgUrl!)
            Alamofire
                .request(imgUrl!)
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        self.imageView.image = UIImage(data: value)
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
    }
}
