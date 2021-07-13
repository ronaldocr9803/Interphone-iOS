//
//  ListNotificationsVC.swift
//  Interphone
//
//  Created by Thang Lai on 05/07/2021.
//

import UIKit

extension ListNotificationsVC: RightMenuDelegate {
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

class ListNotificationsVC: ViewController<ListNotificationsVM> {
    
//    weak var delegate: RightMenuDelegate?

    @IBOutlet weak var listNotificationsTableView: UITableView!
    
//    override func hideBackButton() -> Bool {
//        return true
//    }
    
//    init(viewModel: ListNotificationsVM, navigator: Navigator) {
////        self.navigator = navigator
//        super.init(nibName: nil, bundle: nil)
//        self.navigator = navigator
//        self.viewModel = viewModel
//
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBarTitle(titleScreen)
//        self.navigationItem.title = titleScreen
    }
    
    override var titleScreen: String {
        return "お知らせ"
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if #available(iOS 13.0, *) {
//            self.addRightBarButtonWithImage(UIImage(systemName: "camera")!)
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//    override func hideBackButton()-> Bool{
//        return true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func onMenuClick(_ sender: UIBarButtonItem) {
//        let rightMenu = self.navigator.get(segue: .rightMenu)
//        let vc = MainSlideMenuVC(mainViewController: self, rightMenuViewController: rightMenu)
//        vc.navigator = self.navigator
//        if let rightMenuNavigation: NavigationController = rightMenu as? NavigationController, let rightMenu = rightMenuNavigation.viewControllers[0] as? MenuVC {
//            rightMenu.delegate =  self
//        }
//        vc.viewModel = MainSlideMenuViewModel(provider: self.navigator.provider)
//        let mainNavigationVC = NavigationController(rootViewController: vc)
//        vc.slideMenuController()?.openRight()
//        let vc = self.navigator.get(segue: .home)
//        vc.openRight()
        self.openRight()
//        self.navigator.show(segue: .myAccount, sender: self)
    }
    
    override func makeUI() {
        super.makeUI()
        print("slide: \(self.slideMenuController())")
        listNotificationsTableView.register(cellType: NotificationTableViewCell.self)
        listNotificationsTableView.delegate = self
//        listNotificationsTableView.dataSource = self
        
    }
    

    
    
    override func bindViewModel() {
        super.bindViewModel()
        let input = ListNotificationsVM.Input()
        let output = viewModel.transform(input: input)
        output.listNotifications.drive(listNotificationsTableView.rx.items){ (tableView, index, model) in
            let cell = tableView.dequeueReusableCell(for: IndexPath(item: index, section: 0), cellType: NotificationTableViewCell.self)
            cell.makeFullWidthSeperator()
            cell.fillData(notification: model)
            return cell
        }.disposed(by: disposeBag)
        
        listNotificationsTableView.rx.modelSelected(MockNotification.self)
            .asDriver()
            .drive(onNext: { (notification) in
                self.navigator.show(segue: .detailNotification(notification: notification), sender: self)
                
            }).disposed(by: disposeBag)
    }
}

extension ListNotificationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

