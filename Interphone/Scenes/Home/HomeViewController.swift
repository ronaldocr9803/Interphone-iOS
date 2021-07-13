//
//  HomeViewController.swift
//  ios-template-app
//
//  Created by Thang Lai on 03/07/2021.
//

import UIKit

class HomeViewController: ViewController<HomeViewModel> {

    @IBOutlet weak var menuApp: UIImageView!
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var chatTableView: UITableView!
    init(viewModel: HomeViewModel, navigator: Navigator) {
//        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
        self.navigator = navigator
        self.viewModel = viewModel

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func hideBackButton() -> Bool {
        true
    }
    
    
    override func makeUI() {
        super.makeUI()
        notificationTableView.register(cellType: NotificationTableViewCell.self)
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        
        chatTableView.register(cellType: ChatInfoTableViewCell.self)
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }
    
    override func bindViewModel() {
        menuApp.setOnClickListener { [weak self] (_) in
            guard let self = self else { return }
            print("zo menu")
            self.openRight()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBarController()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationBarController(hide: false)
    }
    
    func setupNavigation() {
        let customView = UIView()
    }


}

extension HomeViewController: ChangeMainMenuVC {
    func changeMainMenuVC(vc: UIViewController) {
        self.slideMenuController()?.changeMainViewController(vc, close: true)
    }
    
    
    
    
}

extension HomeViewController: RightMenuDelegate {
    func didSelectMenuItem(_ item: SlideMenuItem) {
        print("select nay")
        guard let screen: Navigator.Scene = item.screen else {
            return
        }
//        self.navigator.show(target: vc, sender: self, transition: .navigation)
        self.closeRight()
//        changeViewController(item)
        let vc = self.navigator.get(segue: screen)
//        self.slideMenuController()?.mainViewController = vc
        self.slideMenuController()?.changeMainViewController(vc, close: true)
//        self.navigationController?.setViewControllers([vc], animated: false)
//        self.navigator.show(segue: screen, sender: self)
//        self.navigator.show(segue: screen, sender: self, transition: .present)
    }

    
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == notificationTableView {
            return 3
        } else if tableView == chatTableView {
            return 2
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == notificationTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NotificationTableViewCell.self)
            return cell
        } else if tableView == chatTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ChatInfoTableViewCell.self)
            if indexPath.row == 0 {
                cell.circleView.isHidden = false
                if #available(iOS 13.0, *) {
                    cell.bindData(icon: UIImage(systemName: "message.fill")!, text: "1")
                } else {
                    // Fallback on earlier versions
                }

            } else {
                cell.numberLabel.isHidden = false
                if #available(iOS 13.0, *) {
                    cell.bindData(icon: UIImage(systemName: "star.fill")!, text: "5ab")
                } else {
                    // Fallback on earlier versions
                }

            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case notificationTableView:
            let headerView = NotificationHeader()
            if #available(iOS 13.0, *) {
                headerView.bindData(title: "Notification", image: UIImage(systemName: "heart.fill")!)
            } else {
                // Fallback on earlier versions
            }
            return headerView
        case chatTableView:
            let headerView = NotificationHeader()
            if #available(iOS 13.0, *) {
                headerView.bindData(title: "Chat", image: UIImage(systemName: "pencil")!)
            } else {
                // Fallback on earlier versions
            }
            return headerView
        default:
            return UIView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case notificationTableView:
            return 80
        case chatTableView:
            return 50
        default:
            return UITableView.automaticDimension
        }
    }
}
