//
//  MenuVC.swift
//  Interphone
//
//  Created by Thang Lai on 08/07/2021.
//

import UIKit

enum SlideMenuItem {
    case notifications
    case chat
    case intercom
    case deliveryBox
    case family
    case myAccount
    case settings
    
    var screen: Navigator.Scene?{
        switch self {
        case .notifications:
            return .listNotifications
        case .chat:
            return .chat
        case .intercom:
            return .deliveryBox
        case .deliveryBox:
            return .deliveryBox
        case .family:
            return .listNotifications
        case .myAccount:
            return .myAccount
        case .settings:
            return .settings
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .notifications:
            return "Notifications"
        case .chat:
            return "Chat"
        case .intercom:
            return "intercom"
        case .deliveryBox:
            return "delivery box"
        case .family:
            return "family"
        case .myAccount:
            return "Account"
        case .settings:
            return "Settings"
        }
    }
    
    func getIcon() -> UIImage {
        switch self {
        case .notifications:
            return UIImage()
        case .chat:
            return UIImage()
        case .intercom:
            return UIImage()
        case .deliveryBox:
            return UIImage()
        case .family:
            return UIImage()
        case .myAccount:
            return UIImage()
        case .settings:
            return UIImage()
        }
    }
}

protocol RightMenuDelegate: class {
    func didSelectMenuItem(_ item: SlideMenuItem)
}

class MenuVC: ViewController<MenuVM> {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: RightMenuDelegate?
    var mainViewController: UIViewController!
    override func hideBackButton() -> Bool {
        return true
    }
    override func makeUI() {
        super.makeUI()
        tableView.register(cellType: MenuTableViewCell.self)

    }
    
    override func bindViewModel() {
        super.bindViewModel()
        let input = MenuVM.Input()
        let output = viewModel.transform(input: input)
        output.menuItems.drive(tableView.rx.items){ (tableView, index, model) in
            let cell = tableView.dequeueReusableCell(for: IndexPath(item: index, section: 0), cellType: MenuTableViewCell.self)
            cell.makeFullWidthSeperator()
            cell.fillData(menu: model)
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.asDriver().drive(onNext: { [weak self](indexPath) in
            guard let self = `self` else { return }
            self.tableView.deselectRow(at: indexPath, animated: false)
        }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SlideMenuItem.self)
            .asDriver()
            .drive(onNext: { (slideMenu) in
                self.closeLeft()
                let duration: TimeInterval = Double(SlideMenuOptions.animationDuration) - 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.delegate?.didSelectMenuItem(slideMenu)
                    guard let screen: Navigator.Scene = slideMenu.screen else {
                        return
                    }
                    let vc = self.navigator.get(segue: screen)
                    self.slideMenuController()?.changeMainViewController(vc, close: true)
                    
                }
            }).disposed(by: disposeBag)
    }
    

}

