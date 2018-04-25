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
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


// MARK: - UICollectionViewDataSource
extension TravelPhotosCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotosCollectionViewCell
        
        if self.images.count != 0 {
            cell.image = images[indexPath.item].productImg
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let imageVC = storyBoard.instantiateViewController(withIdentifier: "DetailPhotoViewController") as! DetailPhotoViewController
        
        if self.images.count != 0 {
            imageVC.image = images[indexPath.item].productImg
        
            // delegate 처리
            
        }
        
        
        
    }
    
}

// MARK: - UICollectionViewDelegate
extension TravelPhotosCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 70)
    }
}



// MARK: - Photos CollectionView Cell
class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: String? {
        willSet(imgUrl) {
            
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
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 8

    }
}
