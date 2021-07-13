//
//  TableViewCell.swift
//  Ramen
//
//  Created by Duc Do on 2/25/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import UIKit
import RxSwift

class TableViewCell: UITableViewCell {

    var cellDisposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellDisposeBag = DisposeBag()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        disableSelected()
    }
    func disableSelected(){
        self.selectionStyle = .none
    }
    
}
