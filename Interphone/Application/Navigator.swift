//
//  Navigator.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import UIKit

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    
    let provider: DataManager
    
    init(provider: DataManager) {
        self.provider = provider
    }
        
    // MARK: - segues list, all app scenes
    enum RootScene {
        case listNotifications
        case chat
        case intercom
        case deliveryBox
        case familyMembers
        case myAccount
        case settings
    }
    
    enum Scene {
        case splash
        case main
        case home
        case rightMenu
        case myAccount
        case visitorHistory
        case settings
        case listNotifications
        case detailNotification(notification: MockNotification)
        case superMain
        case deliveryBox
        case deliveryBoxDetail(deliveryBox: MockDeliveryBox)
        case chat
    }
    
    enum Transition {
        case root(in: UIWindow, animation: UIView.AnimationOptions?)
        case navigation
        case present
        case customModal
        case alert
        case custom
    }
    
    
    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController {
        var viewController: UIViewController!
        switch segue {
        case .splash:
            viewController =  NavigationController(rootViewController: SplashVC())
        case .rightMenu:
            let menuVC = MenuVC()
            menuVC.viewModel = MenuVM(provider: provider)
            let menuNavigationVC = NavigationController(rootViewController: menuVC)
            return menuVC
        case .main:
            let mainVC = MainVC()
            viewController = NavigationController(rootViewController: mainVC)
        case .superMain:
            let rightMenu = get(segue: .rightMenu)
            let homeVC = get(segue: .home)
            let mainVC = MainSlideMenuVC(mainViewController: homeVC, rightMenuViewController: rightMenu)
            mainVC.navigator = self

            if let rightMenuNavigation: NavigationController = rightMenu as? NavigationController, let rightMenu = rightMenuNavigation.viewControllers[0] as? MenuVC {
                rightMenu.delegate =  (homeVC as! HomeViewController)
            }
            mainVC.viewModel = MainSlideMenuViewModel(provider: provider)
            let mainNavigationVC = NavigationController(rootViewController: mainVC)
            return mainNavigationVC
        case .home:
            let rightMenu = get(segue: .rightMenu) as! MenuVC
//            let homeVC = HomeViewController()
            let homeVC = HomeViewController(viewModel: HomeViewModel(provider: provider), navigator: self)
            rightMenu.mainViewController = homeVC
//            homeVC.viewModel = HomeViewModel(provider: provider)
            rightMenu.navigator = homeVC.navigator
            let nvc: UINavigationController = UINavigationController(rootViewController: homeVC)

            let mainVC = MainSlideMenuVC(mainViewController: homeVC, rightMenuViewController: rightMenu)
            mainVC.navigator = self
//            rightMenu.delegate = 
//            if let rightMenuNavigation: NavigationController = rightMenu as? NavigationController, let rightMenu = rightMenuNavigation.viewControllers[0] as? MenuVC {
//                rightMenu.delegate =  (homeVC as! HomeViewController)
//            }
            mainVC.viewModel = MainSlideMenuViewModel(provider: provider)
            
            let mainNavigationVC = NavigationController(rootViewController: mainVC)
            
            return mainVC

        case .myAccount:
            let rightMenu = get(segue: .rightMenu)
            let myAccountVC = MyAccountVC()
            myAccountVC.navigator = self
//            viewController = NavigationController(rootViewController: myAccountVC)
            let mainVC = SlideMenuController(mainViewController: myAccountVC, rightMenuViewController: rightMenu)
            let mainNavigationVC = UINavigationController(rootViewController: myAccountVC)
            
            return mainNavigationVC
//            return viewController
        case .visitorHistory:
            let visitorHistory = VisitorHistoryVC()
            visitorHistory.viewModel = VisitorHistoryVM(provider: provider)
            visitorHistory.navigator = self
            let mainNavigationVC = UINavigationController(rootViewController: visitorHistory)
            return mainNavigationVC
        case .settings:
            let settings = SettingsVC()
            return settings
        case .listNotifications:
            let rightMenu = get(segue: .rightMenu)
            let settings = ListNotificationsVC()
            settings.viewModel = ListNotificationsVM(provider: provider)
            settings.navigator = Navigator(provider: provider)
//            let mainVC = SlideMenuController(mainViewController: settings, rightMenuViewController: rightMenu)
////            mainVC.navigator = Navigator(provider: provider)
//            if let rightMenuNavigation: NavigationController = rightMenu as? NavigationController, let rightMenu = rightMenuNavigation.viewControllers[0] as? MenuVC {
//                rightMenu.delegate =  settings
//            }
//
            let mainNavigationVC = UINavigationController(rootViewController: settings)
            
            return mainNavigationVC
//            return settings
        case .deliveryBox:
            let deliveryBoxVC = DeliveryBoxVC()
            deliveryBoxVC.viewModel = DeliveryBoxVM(provider: provider)
            deliveryBoxVC.navigator = self
            let mainNavigationVC = UINavigationController(rootViewController: deliveryBoxVC)
            return mainNavigationVC
        case .deliveryBoxDetail(deliveryBox: let deliveryBox):
            let deliveryBoxDetailVC = DeliveryBoxDetailVC()
            let viewModel = DeliveryBoxDetailVM(provider: provider)
            viewModel.deliveryBox = deliveryBox
            deliveryBoxDetailVC.viewModel = viewModel
            return deliveryBoxDetailVC
        case .detailNotification(notification: let notification):
            let vc = DetailNotificationVC()
            let viewModel = DetailNotificationVM(provider: provider)
            viewModel.notification = notification
            vc.viewModel = viewModel
            return vc
        case .chat:
            let chatVC = ChatViewController()
            chatVC.viewModel = ChatViewModel(provider: provider)
            chatVC.navigator = self
            let mainNavigationVC = UINavigationController(rootViewController: chatVC)
            return mainNavigationVC
        }
        
        return viewController
        
    }
    
    func makeRootVC(screen: Scene) -> UIViewController {
        let rightMenu = get(segue: .rightMenu)

        let homeVC = HomeViewController(viewModel: HomeViewModel(provider: provider), navigator: self)
        homeVC.viewModel = HomeViewModel(provider: provider)
        let mainVC = MainSlideMenuVC(mainViewController: homeVC, rightMenuViewController: rightMenu)
        mainVC.navigator = self
        if let rightMenuNavigation: NavigationController = rightMenu as? NavigationController, let rightMenu = rightMenuNavigation.viewControllers[0] as? MenuVC {
            rightMenu.delegate =  (homeVC as! HomeViewController)
        }
        mainVC.viewModel = MainSlideMenuViewModel(provider: provider)
        let mainNavigationVC = NavigationController(rootViewController: mainVC)
        return mainNavigationVC
    }
    
    func pop(sender: UIViewController?, toRoot: Bool = false, animated: Bool = true) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: animated)
        } else {
            sender?.navigationController?.popViewController(animated: animated)
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    func injectTabBarControllers(in target: UITabBarController) {
        if let children = target.viewControllers {
            for vc in children {
                injectNavigator(in: vc)
            }
        }
    }
    
}

// MARK: - invoke a single segue
extension Navigator {
    
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation) {
        let target = get(segue: segue)
        show(target: target, sender: sender, transition: transition)
    }
    
    func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        injectNavigator(in: target)
        
        switch transition {
        case .root(in: let window, let animation):
            window.rootViewController = target
            if let options =  animation{
                window.makeKeyAndVisible()
                UIView.transition(with: window,
                                  duration: 0.3,
                                  options: options,
                                  animations: nil,
                                  completion: nil)
            }
            
            
            return
        case .custom: return
        default: break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        switch transition {
        case .navigation:
            if let nav = sender.navigationController {
                nav.pushViewController(target, animated: true)
            }
            break
        case .present:
            DispatchQueue.main.async {
                target.modalPresentationStyle = .overCurrentContext
                sender.navigationController?.present(target, animated: true, completion: nil)
            }
            break
            
        case .customModal:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                nav.modalPresentationStyle = .fullScreen
                sender.present(nav, animated: true, completion: nil)
            }
            break
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
            break
        default: break
        }
    }
    
    private func injectNavigator(in target: UIViewController) {
        // view controller
        if var target = target as? Navigatable {
            target.navigator = self
            return
        }
        
        
        // navigation controller
        if let target = target as? UINavigationController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
        
        // split controller
        if let target = target as? UISplitViewController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
    }
}
