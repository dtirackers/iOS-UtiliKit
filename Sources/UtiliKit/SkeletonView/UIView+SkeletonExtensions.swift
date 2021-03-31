//
//  UIView+SkeletonExtensions.swift
//  UtiliKit
//
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import UIKit

public extension UIView {

    func applySkeleton(in color: UIColor = .lightGray, cornerRadius: CGFloat = 4.0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        backgroundColor = color

        if let label = self as? UILabel {
            label.text = nil
        }

        if let imageView = self as? UIImageView {
            imageView.image = nil
        }
    }

    func removeSkeleton(withBackground color: UIColor = .clear, cornerRadius: CGFloat = 0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        backgroundColor = color
    }
}
