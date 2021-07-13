//
//  FamilyMembersVC.swift
//  Interphone
//
//  Created by Thang Lai on 07/07/2021.
//

import UIKit

class FamilyMembersVC: ViewController<FamilyMembersVM> {

    override var titleScreen: String {
        return "ファミリー"
    }
    
    override func hideBackButton() -> Bool {
        return true
    }
    
    override func makeUI() {
        
    }




}

extension FamilyMembersVC {
//    func createFooterView() -> UIView {
//        let view = UIView()
//        
//        let label = UILabel()
//        label.text = "Add more member"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(label)
//        
//        label.leadingAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>, constant: <#T##CGFloat#>).isActive = true
//        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        label.heightAnchor.constraint(equalToConstant: bottomLineHeight).isActive = true
//        
//        let forwardView = UIImageView()
//        if #available(iOS 13.0, *) {
//            forwardView.image = UIImage(systemName: "add")
//        } else {
//            // Fallback on earlier versions
//        }
//        forwardView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return view
//    }
}
