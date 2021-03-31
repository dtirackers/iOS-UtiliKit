//
//  ShimmerGradientView.swift
//  UtiliKit-iOS
//
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import UIKit

public enum ShimmerDirection {
    case vertical
    case horizontal
    case custom(startPoint: CGPoint, endPoint: CGPoint)

    public var startPoint: CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x:0.5, y: 0)
        case .horizontal:
            return CGPoint(x: 0, y: 0.5)
        case .custom(startPoint: let start, endPoint: _):
            return start
        }
    }

    public var endPoint: CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 1)
        case .horizontal:
            return CGPoint(x: 1, y: 0.5)
        case .custom(startPoint: _, endPoint: let end):
            return end
        }
    }

    public static var diagonal: ShimmerDirection = .custom(startPoint: CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.8))


    /// Creates a gradient where the gradient is centered around a Pivot `ratio`
    /// - Parameter ratio: unit coordinate space (0-1)
    /// - Returns: A `custom` Direction
    public static func vertical(withPivot ratio: CGFloat) -> ShimmerDirection {
        .custom(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: ratio))
    }
}

public struct ShimmerGradient {

    // MARK: - Properties
    let start: UIColor
    let middle: UIColor?
    let end: UIColor
    let direction: ShimmerDirection

    static let shimmerGradient = ShimmerGradient(start: UIColor.white.withAlphaComponent(0.0),
                                                        middle: UIColor.white.withAlphaComponent(0.2),
                                                        end: UIColor.white.withAlphaComponent(0.0),
                                                        direction: .diagonal)

    // MARK: - Initializers
    ///
    /// - Parameters:
    ///   - start: First color of the gradient
    ///   - middle: Optional color of the gradient. If used it is a transition color between `start` and `end`
    ///   - end: Final color of the gradient 
    ///   - direction: direction of gradient default value is `.vertical`
    init(start: UIColor, middle: UIColor? = nil, end: UIColor, direction: ShimmerDirection = .vertical) {
        self.start = start
        self.middle = middle
        self.end = end
        self.direction = direction
    }

    /// Set a custom `opacity` for the middle white color in the default ShimmerGradient
    /// - Parameter opacity: The `alpha` value for the middle white color
    /// - Returns: a `ShimmerGradient`
    public func withShimmerOpacity(_ opacity: CGFloat) -> ShimmerGradient {
        ShimmerGradient(start: UIColor.white.withAlphaComponent(0.0),
                        middle: UIColor.white.withAlphaComponent(opacity),
                        end: UIColor.white.withAlphaComponent(0.0),
                        direction: .diagonal)
    }
}

@IBDesignable
public class ShimmerGradientView: UIView {

    public override class var layerClass: AnyClass { return CAGradientLayer.self }

    // MARK: - IBInspectables
    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var middleColor: UIColor?
    @IBInspectable var endColor: UIColor = UIColor.white.withAlphaComponent(0.5)

    // MARK: - Lifecycle
    public override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.clear.cgColor
        configureColors(start: startColor, middle: middleColor, end: endColor, direction: .vertical)
    }

    /// Uses a `ShimmerGradient` to set the required colors
    /// - Parameters:
    ///   - shimmerGradient: A modal that stores the required information used by `ShimmerGradientView`
    func configure(with shimmerGradient: ShimmerGradient) {
        configureColors(start: shimmerGradient.start, middle: shimmerGradient.middle, end: shimmerGradient.end, direction: shimmerGradient.direction)
    }

    /// Allows you to customize the Shimmer's gradient colors to better match your project
    /// - Parameters:
    ///   - start: The color the gradient should start off with
    ///   - middle: The color the gradient should transition to
    ///   - end: The color the gradient should transition to before the end
    ///   - direction: This sets where the `start` and `end` will appear in relation to the view
    public func configureColors(start: UIColor, middle: UIColor?, end:UIColor, direction: ShimmerDirection) {
        guard let layer = layer as? CAGradientLayer else { return }

        startColor = start
        middleColor = middle
        endColor = end

        layer.colors = [startColor.cgColor, middleColor?.cgColor, endColor.cgColor].compactMap { $0 }

        switch direction {
        case .vertical:
            layer.locations = [0.0, 1.0]
        case .horizontal:
            layer.startPoint = CGPoint(x: 0,y: 0)
            layer.endPoint = CGPoint(x: 1, y: 0)
        case .custom(startPoint: let startPoint, endPoint: let endPoint):
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
    }
}

