//
//  Shimmer.swift
//  UtiliKit-iOS
//
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import UIKit

public protocol Shimmer: AnyObject {

    var shimmerContainer: UIView { get }
    var shimmerView: ShimmerGradientView? { get set }
    var isShimmering: Bool { get }

    func applyShimmer(with animation: ShimmerAnimation)
    func removeShimmer(animation: ShimmerAnimation)
}

public extension Shimmer {
    var isShimmering: Bool { shimmerView != nil }

    func applyShimmer(with animation: ShimmerAnimation = .defaultAnimation) {
        if isShimmering { removeShimmer() }

        let gradientView = ShimmerGradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.configure(with: animation.shimmerGradient)
        shimmerContainer.addSubview(gradientView)
        shimmerView = gradientView

        let basicAnimation = animation.basicAnimation
        basicAnimation.fromValue = -shimmerContainer.frame.width / 2.0
        basicAnimation.toValue = shimmerContainer.frame.width * 1.25
        basicAnimation.isRemovedOnCompletion = false
        gradientView.layer.add(basicAnimation, forKey: animation.key)

        NSLayoutConstraint.activate([gradientView.leadingAnchor.constraint(equalTo: shimmerContainer.leadingAnchor),
                                     gradientView.widthAnchor.constraint(equalTo: shimmerContainer.widthAnchor, multiplier: 0.5),
                                     gradientView.topAnchor.constraint(equalTo: shimmerContainer.topAnchor),
                                     gradientView.bottomAnchor.constraint(equalTo: shimmerContainer.bottomAnchor)])
    }

    func removeShimmer(animation: ShimmerAnimation = .defaultAnimation) {
        shimmerView?.removeFromSuperview()
    }
}

// MARK: - UIView + Shimmer
public extension Shimmer where Self: UIView {
    var shimmerContainer: UIView { return self }
}

// MARK: - UICollectionViewCell + Shimmer
public extension Shimmer where Self: UICollectionViewCell {
    var shimmerContainer: UIView { return contentView }
}

// MARK: - UITableViewCell + Shimmer
public extension Shimmer where Self: UITableViewCell {
    var shimmerContainer: UIView { return contentView }
}

// MARK: - UIViewController + Shimmer
public extension Shimmer where Self: UIViewController {
    var shimmerContainer: UIView { return view }
}

// MARK: - ShimmerAnimation
public struct ShimmerAnimation {

    let key: String
    let duration: TimeInterval
    let timingFunction: CAMediaTimingFunction
    let animationKeyPath = "transform.translation.x"
    let shimmerGradient: ShimmerGradient

    var basicAnimation: CABasicAnimation {
        let basicAnimation = CABasicAnimation(keyPath: animationKeyPath)
        basicAnimation.duration = duration
        basicAnimation.timingFunction = timingFunction
        basicAnimation.repeatCount = Float.greatestFiniteMagnitude
        return basicAnimation
    }

    public static let defaultAnimation = ShimmerAnimation(key: "shimmer", duration: 2.2, timingFunction: CAMediaTimingFunction(name: .easeInEaseOut))

    ///
    /// - Parameters:
    ///   - key: Name of the animation
    ///   - duration: length of time the animation plays out
    ///   - timingFunction: `CAMediaTimingFunction` for how the animation should transition
    ///   - shimmerGradient: a Custom `ShimmerGradient` to better match your design
    init(key: String, duration: TimeInterval, timingFunction: CAMediaTimingFunction, shimmerGradient: ShimmerGradient = .shimmerGradient) {
        self.key = key
        self.duration = duration
        self.timingFunction = timingFunction
        self.shimmerGradient = shimmerGradient
    }

    /// You want the default `ShimmerGradient` but with a custom opacity
    /// - Parameter opacity: the opacity of the middle white in the default `ShimmerGradient`
    init(with opacity: CGFloat) {
        self.key = "opacityShimmer"
        self.duration = 2.2
        self.timingFunction = CAMediaTimingFunction(name: .easeIn)
        self.shimmerGradient = ShimmerGradient.shimmerGradient.withShimmerOpacity(opacity, with: .diagonal)
    }
}
