//
//  CollectionSectionViewRegisterDequeueProtocol.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import UIKit

protocol CollectionSectionViewRegisterDequeueProtocol {
    static func registerHeaderView(to collectionView: UICollectionView)
    static func registerFooterView(to collectionView: UICollectionView)
    static func dequeueReusableheaderView(to collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, indexPath: IndexPath) -> Self
    static func dequeueReusablefooterView(to collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, indexPath: IndexPath) -> Self
    static var reuseIdentifier: String { get }
}

extension CollectionSectionViewRegisterDequeueProtocol where Self: UICollectionReusableView  {
    static func registerHeaderView(to collectionView: UICollectionView) {
        collectionView.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.reuseIdentifier)
    }
    
    static func registerFooterView(to collectionView: UICollectionView) {
        collectionView.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.reuseIdentifier)
    }
    
    static func dequeueReusableheaderView(to collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, indexPath: IndexPath) -> Self {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? Self else { fatalError("Error! \(self.reuseIdentifier)") }
        return headerView
    }
    
    static func dequeueReusablefooterView(to collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, indexPath: IndexPath) -> Self {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? Self else { fatalError("Error! \(self.reuseIdentifier)") }
        return footerView
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: CollectionSectionViewRegisterDequeueProtocol {}
