//
//  SplashVC.swift
//  ios-template-app
//
//  Created by OpenYourEyes on 05/01/2021.
//

import UIKit

class SplashVC: ViewController<SplashVM> {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBarController()
        postDelay(timeDelay: .seconds(1)) {
            Application.shared.showMain()
//            let vc = VisitorHistoryVC()
//            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}
