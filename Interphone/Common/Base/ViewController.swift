//
//  ViewController.swift
//  Ramen
//
//  Created by Duc Do on 2/20/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class ViewController<T: ViewModel>: UIViewController, Navigatable, NVActivityIndicatorViewable {
    
    lazy var appString: Localizable.App.Type = {
        return Localizable.App.self
    }()
    
    var viewModel: T!
    var navigator: Navigator!
    var dataManager: DataManager!
    
    let isLoading = BehaviorRelay(value: false)
    let trackingError: PublishSubject<Error> = {
        return PublishSubject()
    }()
    var disposeBag = DisposeBag()
    
    private(set) var titleScreen: String =  ""
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    lazy var backBarButton: UIBarButtonItem = {
//        let image = UIImage(named: "ic_button_back")?.withRenderingMode(.alwaysOriginal)
//
//        let view = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onButtonBackClick(_:)))
        let view = UIBarButtonItem()
        view.imageInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0)
        view.title = ""
        return view
    }()
    
    lazy var menuBarButton: UIBarButtonItem = {
//        let image = UIImage(named: "ic_button_back")?.withRenderingMode(.alwaysOriginal)
//
//        let view = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: #selector(onMenuClick(_:)))
        let view = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(onMenuClick(_:)))
//        view.imageInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0)
//        view.title = "Menu"
        return view
    }()
    @objc func onMenuClick(_ sender:UIBarButtonItem){
        print("tap nay")
//        let vc = self.navigator.get(segue: .home)
//        let vc = MainSlideMenuVC(mainViewController: self, rightMenuViewController: self.navigator.get(segue: .rightMenu))
//        vc.navigator = self.navigator
//        NavigationController(rootViewController: vc).openRight()
        self.openRight()
//        self.navigator.makeRootVC(screen: self)
//        self.slideMenuController()?.openRight()
    }
    func hideBackButton()-> Bool{
        return false
    }
    
    func hideRightBarButton() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
//        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = titleScreen
//        if !hideBackButton(){
//            navigationItem.leftBarButtonItem = backBarButton
//        }
        
        if !hideRightBarButton(){
            navigationItem.rightBarButtonItem = menuBarButton
            //open right menu
        }
//        dataManager = navigator.provider
//        viewModel = ViewModelFactory.of(type: T.self, data: dataManager)
        bindDefault()
        localizationText()
        makeUI()
        bindViewModel()
    }
    
    private func bindDefault(){
        isLoading.asDriver()
            .drive(onNext: { [weak self] (isAnimating) in
                guard let `self` = self else { return }
                if isAnimating {
                    self.startAnimating()
                } else {
                    self.stopAnimating()
                }
            }).disposed(by: disposeBag)
        
        
        trackingError.asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] (error) in
                guard let `self` = self else { return }
                if error is BaseErrorResponse{
                    let errorResponse = error as! BaseErrorResponse
                    if errorResponse.tokenExpired(){
                        self.dataManager.onLogout()
//                        self.navigator.show(segue: .login(isTokenExpired: true), sender: self, transition: .customModal)
                        return
                    }
                }
                self.showAlertError(error: error)
            }).disposed(by: disposeBag)
    }
    func localizationText(){
        
    }
    
    @objc func onButtonBackClick(_ sender:UIBarButtonItem){
        self.navigator.pop(sender: self)
    }
    
    func makeUI() {
        
    }
    
    func bindViewModel() {
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func bindTrackingError(){
        viewModel.trackingError.asObserver().bind(to: self.trackingError).disposed(by: disposeBag)
    }
    func bindLoading(){
        viewModel.loading.asObservable().bind(to: self.isLoading).disposed(by: disposeBag)
    }
    
    
    deinit {
        printLog(self, "Deinited")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
}
extension ViewController{
    func hideNavigationBarController(hide:Bool = true){
        self.navigationController?.setNavigationBarHidden(hide, animated: false)
    }
    func showAlertError(error: Error, completion: (() ->Void)? = nil) {
        let alertController  =   AlertController.showAlertSingleButton(title: "",
                                                                       message: error.localizedDescription,
                                                                       buttonTitle: "OK",
                                                                       completion: completion)
        self.navigator.show(target: alertController, sender: self, transition: .alert)
    }
    func showAlertError(title: String, error: String, completion: (() ->Void)? = nil) {
        let alertController  =   AlertController.showAlertSingleButton(title: title,
                                                                       message: error,
                                                                       buttonTitle: "OK",
                                                                       completion: completion)
        self.navigator.show(target: alertController, sender: self, transition: .alert)
    }
    
    func showAlertConfirm(title: String?,
                          message: String?,
                          buttonOK: String = Localizable.App.OK.toString,
                          buttonCancel: String = Localizable.App.NO.toString,
                          completion: (() -> Void)? = nil){
        let alertController = AlertController.showAlertConfirm(title: title,
                                                               message: message,
                                                               buttonOK: buttonOK,
                                                               buttonCancel: buttonCancel,
                                                               completion: completion)
        self.navigator.show(target: alertController, sender: self, transition: .alert)
    }
    
}

