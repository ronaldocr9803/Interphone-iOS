//
//  ScrollView+Paging.swift
//  Ramen
//
//  Created by Duc Do on 2/25/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import KafkaRefresh
enum LoadListDataType {
    case refresh, loadMore
}

protocol PagingIndicator {
    var headerLoading: RxActivityIndicator { get }
    var footerLoading: RxActivityIndicator { get }
    var endOfPage: BehaviorRelay<Bool> { get }
    
    var page: Int { get set }
    var limit: Int{ get }
    
}

protocol ScrollViewPaging: class {
    
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerRefreshTrigger: PublishRelay<Void> { get }
    
    var isHeaderLoading: BehaviorRelay<Bool> { get }
    var isFooterLoading: BehaviorRelay<Bool> { get }
    
    var pagingScrollView: UIScrollView { get }
    
    var disposeBag: DisposeBag { get }
}

extension ScrollViewPaging {
    func configPaging() {
        pagingScrollView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
            guard let `self` = self else { return }
            if self.pagingScrollView.headRefreshControl.isTriggeredRefreshByUser == false {
                self.setEndOfPage(isEnOfPage: false)
                self.headerRefreshTrigger.accept(())
            }
        })
        pagingScrollView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            guard let `self` = self else { return }
            self.footerRefreshTrigger.accept(())
        })
        
        pagingScrollView.footRefreshControl.autoRefreshOnFoot = true
        
        isHeaderLoading.bind(to: pagingScrollView.headRefreshControl.rx.isAnimating)
            .disposed(by: disposeBag)
        isFooterLoading.bind(to: pagingScrollView.footRefreshControl.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func subscribePagingIndicator(_ pagingIndicator: PagingIndicator) {
        pagingIndicator.headerLoading
            .asObservable()
            .bind(to: isHeaderLoading)
            .disposed(by: disposeBag)
        
        pagingIndicator.footerLoading
            .asObservable()
            .bind(to: isFooterLoading)
            .disposed(by: disposeBag)
        
        pagingIndicator.endOfPage
            .asDriver().skip(1).drive(onNext: { [weak self] (value) in
                guard let self = self else { return }
                self.setEndOfPage(isEnOfPage: value)
            }).disposed(by: disposeBag)
    }
    
    func setEndOfPage(isEnOfPage: Bool){
        printLog(self, "isEnOfPage \(isEnOfPage)")
        if isEnOfPage {
            self.pagingScrollView.footRefreshControl.endRefreshingAndNoLongerRefreshing(withAlertText: nil)
            self.pagingScrollView.footRefreshControl.isHidden = true
        }else{
            self.pagingScrollView.footRefreshControl.resumeRefreshAvailable()
            self.pagingScrollView.footRefreshControl.isHidden = false
        }
        
    }
}
