//
//  MainSlideMenu.swift
//  Ramen
//
//  Created by Duc Do on 2/25/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainSlideMenuVC: SlideMenuController, Navigatable {
    
    var navigator: Navigator!
    
    
    var viewModel: MainSlideMenuViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
//    var menuLeft: MenuVC? { return rightViewController as? MenuVC }
//    var mainHome: HomeViewController? { return mainViewController as? HomeViewController }
//    override func awakeFromNib() {
//        let menuVC = MenuVC()
//        self.rightViewController = menuVC
//        
//        let homeVC = HomeViewController()
//        self.mainViewController = homeVC
//        super.awakeFromNib()
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigation()
//        makeUI()
//    }
    
    func setupNavigation() {
//        let navigationBarView = UIView()
//        let backButton = UIButton()
//        backButton.setTitle("Back", for: .normal)
//        backButton.setTitleColor(.black, for: .normal)
//        navigationBarView.addSubview(backButton)
//        backButton.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(30)
//        }
//        self.view.addSubview(navigationBarView)
//        navigationBarView.snp.makeConstraints { (make) in
//            make.leading.equalTo(self.view).offset(0)
//            make.trailing.equalTo(self.view).offset(0)
//            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
//            make.height.equalTo(80)
//        }
//        navigationBarView.backgroundColor = .yellow
//        let navigationTitle = UILabel()
//        navigationTitle.text = "Test"
//        navigationBarView.addSubview(navigationTitle)
//        navigationTitle.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
//        let customView = UIView()
//        customView.translatesAutoresizingMaskIntoConstraints = false
//        customView.addConstraint(NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
//        customView.addConstraint(NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
//        let imageMenu = UIImageView(image: UIImage(named: "ic_menu"))
//        customView.addSubview(imageMenu)
//        imageMenu.snp.makeConstraints { (make) in
//            make.leading.trailing.bottom.top.equalTo(customView).offset(0)
//        }
//
//        navigationBarView.addSubview(customView)
//
//        customView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.right.equalTo(navigationBarView).offset(-30)
//        }
        
        
        
        
        
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.addConstraint(NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        customView.addConstraint(NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        let imageMenu = UIImageView(image: UIImage(named: "ic_menu"))
        customView.addSubview(imageMenu)
//        imageMenu.translatesAutoresizingMaskIntoConstraints = false
        imageMenu.snp.makeConstraints { (make) in
            make.leading.equalTo(customView).offset(0)
            make.trailing.equalTo(customView).offset(0)
            make.top.equalTo(customView).offset(0)
            make.bottom.equalTo(customView).offset(0)
        }


        let menuButton = UIBarButtonItem(customView: imageMenu)
        imageMenu.setOnClickListener { (_) in
            self.openRight()
        }
        navigationItem.rightBarButtonItems = [menuButton]
        navigationController?.additionalSafeAreaInsets.top = 30

    }
    
    private func makeUI() {
        
    }
    
    private func bindViewModel() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is ListNotificationsVC ||
            vc is MyAccountVC ||
            vc is SettingsVC {
                return true
            }
        }
        return false
    }
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        if let slide = viewController as? SlideMenuController {
            return topViewController(slide.mainViewController)
        }
        return viewController
    }
}
