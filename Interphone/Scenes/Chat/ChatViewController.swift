//
//  ChatViewController.swift
//  Interphone
//
//  Created by Thang Lai on 12/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ChatViewController: ViewController<ChatViewModel> {

    override var titleScreen: String {
        return "Chat"
    }
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var heightMessageUIView: NSLayoutConstraint!
    @IBOutlet weak var bottomMessageUIView: NSLayoutConstraint!
    
    private var isOversized = false {
        didSet {
            guard oldValue != isOversized else {
                return
            }
            
            messageTextView.layoutIfNeeded()
            messageTextView.isScrollEnabled = isOversized
            messageTextView.setNeedsUpdateConstraints()
            
        }
    }
    
    override func makeUI() {
        chatTableView.register(cellType: MessageMeCell.self)
        chatTableView.register(cellType: MessageYouCell.self)
        messageTextView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        messageTextView.isScrollEnabled = false
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        let input = ChatViewModel.Input()
        let output = viewModel.transform(input: input)
        output.listNotifications.drive(chatTableView.rx.items){ (tableView, index, model) in
            if model.sender {
                let cell = tableView.dequeueReusableCell(for: IndexPath(item: index, section: 0), cellType: MessageYouCell.self)
                cell.fillData(mockChat: model)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(for: IndexPath(item: index, section: 0), cellType: MessageMeCell.self)
                cell.fillData(mockChat: model)
                return cell
            }
        }.disposed(by: disposeBag)
    }
    

}

extension ChatViewController {
    @objc func keyboardWillHide(notification:NSNotification) {
//        tblViewListData.frame.size.height = fltTblHeight
        bottomMessageUIView.constant = 0
//        self.messageTableView.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }


    /*  UIKeyboardWillShowNotification. */
    @objc internal func keyboardWillShow(_ notification : Notification?) -> Void {
        calculateKeyboardSize(notification) { (keyboardSize) in
            let heightTabBar = self.tabBarController?.tabBar.frame.height ?? 49.0

            self.bottomMessageUIView.constant = keyboardSize.height - heightTabBar
            self.chatTableView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        print(messageTextView.font?.lineHeight)
//        if heightTextView.constant >= messageTextView.font!.lineHeight * 3 {
//            isOversized = true
//        } //else {
        
        let size = CGSize(width: messageTextView.frame.width, height: .infinity)
        let estimateSize = messageTextView.sizeThatFits(size)
        if estimateSize.height >= messageTextView.font!.lineHeight * 5 {
            isOversized = true
        } else {
            heightMessageUIView.constant = estimateSize.height + 15
            view.layoutIfNeeded()
        }
        chatTableView.layoutIfNeeded()
    }
}
