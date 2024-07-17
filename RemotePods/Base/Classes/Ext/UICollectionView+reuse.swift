//
//  UICollectionView+reuse.swift
//  Base
//
//  Created by zhaoshouwen on 2024/7/17.
//

import UIKit

private var kCellRegisterTable: Void?
private var kSupplementaryViewRegisterTable: Void?

// MARK: 注册复用
extension NameSpace where Base: UICollectionView {
    
    /// 免注册复用cell，未注册时会自动注册，并记录到cellRegisterTable
    public func dequeueCell<T: UICollectionViewCell>(_ className: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: className)
        if !base.cellRegisterTable.contains(identifier) {
            register(cell: className)
        }
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            assertionFailure("Couldn't find UICollectionViewCell for \(identifier)")
            return T()
        }
        return cell
    }
    
    /// 免注册复用supplementary view，未注册时会自动注册，并记录到supplementaryViewRegisterTable
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, withClassName className: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: className)
        
        guard let supplementaryView = base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            assertionFailure("Couldn't find UICollectionReusableView for \(identifier)")
            return T()
        }
        return supplementaryView
    }
    
    /// 注册supplementary view，记录到supplementaryViewRegisterTable
    public func register<T: UICollectionReusableView>(_ className: T.Type, forSupplementaryViewOfKind elementKind: String) {
        let identifier = String(describing: className)
        base.supplementaryViewRegisterTable.insert(identifier)
        base.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }
    
    /// 注册cell，记录到cellRegisterTable
    public func register<T: UICollectionViewCell>(cell className: T.Type) {
        let identifier = String(describing: className)
        base.cellRegisterTable.insert(identifier)
        base.register(T.self, forCellWithReuseIdentifier: identifier)
    }
}

private extension UICollectionView {
    var cellRegisterTable: Set<String> {
        get {
            if let table = objc_getAssociatedObject(self, &kCellRegisterTable) as? Set<String> {
                return table
            } else {
                objc_setAssociatedObject(self, &kCellRegisterTable, Set<String>(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return []
            }
        }
        set {
            objc_setAssociatedObject(self, &kCellRegisterTable, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var supplementaryViewRegisterTable: Set<String> {
        get {
            if let table = objc_getAssociatedObject(self, &kSupplementaryViewRegisterTable) as? Set<String> {
                return table
            } else {
                objc_setAssociatedObject(self, &kSupplementaryViewRegisterTable, Set<String>(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return []
            }
        }
        set {
            objc_setAssociatedObject(self, &kSupplementaryViewRegisterTable, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

