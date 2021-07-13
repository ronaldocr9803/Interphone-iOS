//
//  BaseViewController.swift
//  Interphone
//
//  Created by Thang Lai on 09/07/2021.
//

import UIKit

protocol ChangeMainMenuVC: class {
    func changeMainMenuVC(vc: UIViewController)
}



class BaseViewController<T: ViewModel>: ViewController<T> {
    weak var delegate: ChangeMainMenuVC?


    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()

    }


    func setupNavigation() {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.addConstraint(NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        customView.addConstraint(NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        let imageMenu = UIImageView(image: UIImage(named: "ic_menu"))
        customView.addSubview(imageMenu)


        let menuButton = UIBarButtonItem(customView: customView)
        customView.setOnClickListener { (_) in
             self.openRight()
        }
        navigationItem.rightBarButtonItems = [menuButton]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBarController(hide: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideNavigationBarController(hide: false)
    }
}

extension BaseViewController: RightMenuDelegate {
    func didSelectMenuItem(_ item: SlideMenuItem) {
        print("select nay")
        guard let screen: Navigator.Scene = item.screen else {
            return
        }
//        self.navigator.show(target: vc, sender: self, transition: .navigation)
        self.closeRight()
//        changeViewController(item)
        self.navigator.show(segue: screen, sender: self)
        
    }
}
