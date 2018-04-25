//
//  WishListButton.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 18..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class WishListButton: UIButton {
    
    static let standards = WishListButton()
    
    var isWishList: Bool = false {
        willSet {
            if newValue {
                heartImageView.image = UIImage(named: heartIconImage)
            } else {
                heartImageView.image = UIImage(named: heartIconNoneSelect)
            }
        }
    }
    
    var pk: Int?
    
    let iconSize: CGFloat = 24
    
    private var heartImageView: UIImageView!
    private let heartIconNoneSelect = "ic_favorites_white"
    private let heartIconImage = "ic_favorites_full"
    
    let header: Dictionary<String, String> = ["Authorization": "Token " + (UserData.user.token ?? "nope")]
    private let url = UrlData.standards.basic + UrlData.standards.wishList
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: iconSize, height: iconSize))
        
        heartImageViewUpdateLayout()
        self.setUp()
    }
    
    convenience init(frame: CGRect, pk: Int) {
        self.init(frame: frame)
        self.pk = pk
        
        heartImageViewUpdateLayout()
        self.setUp()
    }
    
    
    // 하트 이미지 생성
    private func heartImageViewUpdateLayout() {
        heartImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        checkWishList(self)
        self.addSubview(heartImageView)
    }
    
    func checkWishList(_ sender: WishListButton) {
        let wishList = UserData.user.wishListPrimaryKeys
        for pk in wishList {
            if pk == sender.tag {
                self.isWishList = true
                break
            } else {
                self.isWishList = false
            }
        }
    }
    
    
    // 커스텀 UIButton 클릭시 항상 clickWishListButton 메소드 호출
    private func setUp() {
        self.addTarget(self, action: #selector(clickWishListButton(_:)), for: .touchUpInside)
    }
    
    
    
    // 버튼 클릭시 호출
    // 위시리스트인지 체크 후, Bool 값 변경 & 하트 이미지 변경
    @objc private func clickWishListButton(_ sender: WishListButton) {
        
        // 이미 위시리스트에 있을 경우
        if self.isWishList {
            self.isWishList = false
            heartImageView.image = UIImage(named: heartIconNoneSelect)
//            deleteWishList(sender.tag)
            print("deleteWishList")
        } else {
        // 위시리스트에 없는 경우
            self.isWishList = true
            heartImageView.image = UIImage(named: heartIconImage)
            addWishList(sender.tag)
        }
    }  
    
    
    deinit {
        self.removeTarget(self, action: #selector(clickWishListButton(_:)), for: .touchUpInside)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK:  - About WishList
extension WishListButton {
    
    // 위시리스트 목록 가져오기
    func fetchWishList() -> [Int] {
        return UserData.user.wishListPrimaryKeys
    }
    
    
    // wishList에 추가
    private func addWishList(_ pk: Int) {
        let pkList = UserData.user.wishListPrimaryKeys
        
        // 중복 Pk 아닌지 체크
        if !pkList.contains(pk) {
            // 싱글턴 리스트에 추가
            UserData.user.setWishListPrimaryKeys(wishListPrimaryKey: pk)
            
            // data post to server
            let param = ["travel_info": pk]
            Alamofire
                .request(url, method: .post, parameters: param, headers: header)
                .responseJSON { (response) in
                    if let responseValue = response.result.value as! [String:Any]? {
                        print("\n---------- [ dataPost ] -----------\n")
                        print(responseValue)
                    }
            }
        }
    }
    
    
    // 위시리스트 삭제
    func deleteWishList(_ pk: Int) {
        
        let pkList = UserData.user.wishListPrimaryKeys
        
        // 리스트에 pk있는지 체크
        if pkList.contains(pk) {
            // 싱글턴 리스트에서 삭제
            while let idx = pkList.index(of: pk) {
                UserData.user.removeWishListPrimaryKey(of: idx)

            }
            
            // 서버 전달
            let url = self.url + UrlData.standards.wishListDelete
            let param = ["travel_info": pk]
            
            // 500 에러 ㅜ.ㅜ
            Alamofire
                .request(url, method: .delete, parameters: param, headers: header)
                .responseJSON { (response) in
                    if let responseValue = response.result.value as! [String:Any]? {
                        print("\n---------- [ dataPost ] -----------\n")
                        print(responseValue)
                    }
            }
        }
    }
}
