//
//  Kingfisher+Rx.swift
//  Ramen
//
//  Created by Duc Do on 2/20/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

extension Reactive where Base: UIImageView {

    public var imageURL: Binder<URL?> {
        return self.imageURL(withPlaceholder: nil)
    }

    public func imageURL(withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo? = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.kf.setImage(with: url,
                                  placeholder: placeholderImage,
                                  options: options)
        })
    }
}
