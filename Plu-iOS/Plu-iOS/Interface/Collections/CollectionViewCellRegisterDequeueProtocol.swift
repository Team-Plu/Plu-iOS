//
//  CollectionViewCellRegisterDequeueProtocol.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import UIKit

protocol CollectionViewCellRegisterDequeueProtocol {
    static func register(to collectionView: UICollectionView)
    static func dequeueReusableCell(to collectionView: UICollectionView, indexPath: IndexPath) -> Self
    static var reuseIdentifier: String { get }
}


extension CollectionViewCellRegisterDequeueProtocol where Self: UICollectionViewCell {
    static func register(to collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
    static func dequeueReusableCell(to collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? Self else { fatalError() }
        return cell
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CollectionViewCellRegisterDequeueProtocol {}
