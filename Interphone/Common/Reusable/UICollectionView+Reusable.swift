/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit
import RxSwift
import RxCocoa
// MARK: Reusable support for UICollectionView

public extension UICollectionView {
    /**
     Register a NIB-Based `UICollectionViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
     
     - parameter cellType: the `UICollectionViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
     
     - seealso: `register(_:,forCellWithReuseIdentifier:)`
     */
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)
     
     - parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register
     
     - seealso: `register(_:,forCellWithReuseIdentifier:)`
     */
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
     
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     
     - returns: A `Reusable`, `UICollectionViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withReuseIdentifier:,for:)`
     */
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = bareCell as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    
    /**
     Register a NIB-Based `UICollectionReusableView` subclass (conforming to `Reusable` & `NibLoadable`)
     as a Supplementary View
     
     - parameter supplementaryViewType: the `UIView` (`Reusable` & `NibLoadable`-conforming) subclass
     to register as Supplementary View
     - parameter elementKind: The kind of supplementary view to create.
     
     - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable & NibLoadable {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
    
    /**
     Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View
     
     - parameter supplementaryViewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View
     - parameter elementKind: The kind of supplementary view to create.
     
     - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable {
            self.register(
                supplementaryViewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
    
    /**
     Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type
     
     - parameter elementKind: The kind of supplementary view to retrieve.
     - parameter indexPath:   The index path specifying the location of the cell.
     - parameter viewType: The view class to dequeue
     
     - returns: A `Reusable`, `UICollectionReusableView` instance
     
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:,for:)`
     */
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
        where T: Reusable {
            let view = self.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier,
                for: indexPath
            )
            guard let typedView = view as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
            }
            return typedView
    }
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.sizeToFit()
        label.textAlignment = .center
        
        self.backgroundView = label
    }
    
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
    }
    
}
extension Reactive where Base: UICollectionView {
    func isEmpty(message: String, textColor color: UIColor = UIColor.black) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            printLog(self, "isEmpty \(isEmpty)")
            if isEmpty {
                tableView.setNoDataPlaceholder(message)
            } else {
                tableView.removeNoDataPlaceholder()
            }
        }
    }
}
