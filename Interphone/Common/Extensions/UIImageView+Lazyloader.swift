//
//  UIImageView+Lazyloader.swift
//  Zaimane
//
//  Created by Benjie on 8/25/20.
//  Copyright © 2020 WillGroup. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Kingfisher
extension UIImageView {
    func downloadImageFrom(link:String, size: CGSize, contentMode: UIView.ContentMode) {
         URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
             (data, response, error) -> Void in
             DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data)?.resized(to: size) }
             }
         }).resume()
     }
}

extension UIImageView{
    func loadImage(url path:String?, isRound: Bool = false, placeholder: UIImage? = UIImage(named: "placeholder")){
        if let path = path, let url  = URL(string: path){
            self.kf.setImage(with: url, placeholder: placeholder){ result in
                // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    printLog(self,"errorLoadImage \(error)") // The error happens
                    self.image = placeholder
                    break
                }
            }
        }else{
            self.image = placeholder
        }
    }
}
