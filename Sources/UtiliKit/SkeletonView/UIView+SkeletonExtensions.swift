//
//  UIView+SkeletonExtensions.swift
//  UtiliKit
//
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import UIKit

public extension UIView {

    /// This will update a view to be a blank view
    /// - Parameters:
    ///   - color: The background of the view being used as a skeleton
    ///   - cornerRadius: The value for the `layer.cornerRadius`
    func applySkeleton(withBackground color: UIColor = .lightGray, cornerRadius: CGFloat = 4.0) {
        if let collection = self as? UICollectionView {
            collection.visibleCells.forEach{ $0.applySkeleton(withBackground: color, cornerRadius: cornerRadius) }
            return
        }

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        backgroundColor = color

        if let label = self as? UILabel {
            label.text = nil
        }

        if let imageView = self as? UIImageView {
            imageView.image = nil
        }

        subviews.forEach { $0.isHidden = true }
    }

    /// This will update the
    /// - Parameters:
    ///   - color: The color to update the background to
    ///   - cornerRadius:The value for the `layer.cornerRadius`
    func removeSkeleton(withBackground color: UIColor = .clear, cornerRadius: CGFloat = 0) {
        if let collection = self as? UICollectionView {
            collection.visibleCells.forEach{ $0.removeSkeleton(withBackground: color, cornerRadius: cornerRadius) }
            return
        }

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        backgroundColor = color
        subviews.forEach { $0.isHidden = false }
    }
}
