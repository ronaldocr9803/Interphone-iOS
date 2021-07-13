//
//  NavigationController.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return  .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        hero.isEnabled = true
//        hero.modalAnimationType = .autoReverse(presenting: .fade)
//        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))

        navigationBar.isTranslucent = false
    }
}

