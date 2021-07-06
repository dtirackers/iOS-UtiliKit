//
//  ShimmerGradientViewTest.swift
//  UtiliKit-iOSTests
//
//  Created by Eugene Heckert on 7/3/21.
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import XCTest
@testable import UtiliKit

class ShimmerGradientViewTest: XCTestCase {

    // MARK: - ShimmerDirection
    func test_ShimmerDirection_Vertical() {
        XCTAssertEqual(ShimmerDirection.vertical.startPoint, CGPoint(x: 0.5, y: 0))
        XCTAssertEqual(ShimmerDirection.vertical.endPoint, CGPoint(x: 0.5, y: 1))
    }

    func test_ShimmerDirection_Horizontal() {
        XCTAssertEqual(ShimmerDirection.horizontal.startPoint, CGPoint(x: 0, y: 0.5))
        XCTAssertEqual(ShimmerDirection.horizontal.endPoint, CGPoint(x: 1, y: 0.5))
    }

    func test_ShimmerDirection_Custom() {
        let customDirection = ShimmerDirection.custom(startPoint: .zero, endPoint: CGPoint.init(x: 1, y: 1))
        XCTAssertEqual(customDirection.startPoint, .zero)
        XCTAssertEqual(customDirection.endPoint, CGPoint(x: 1, y: 1))
    }

    func test_ShimmerDirection_Diagonal() {
        XCTAssertEqual(ShimmerDirection.diagonal.startPoint, CGPoint(x: 0.5, y: 1.0))
        XCTAssertEqual(ShimmerDirection.diagonal.endPoint, CGPoint(x: 0.0, y: 0.8))
    }

    func test_ShimmerDirection_VerticalWithPivot() {
        let verticalWithPivot = ShimmerDirection.vertical(withPivot: 0.5)
        XCTAssertEqual(verticalWithPivot.startPoint, .zero)
        XCTAssertEqual(verticalWithPivot.endPoint, CGPoint(x: 0.0, y: 0.5))
    }

    // MARK: - ShimmerGradient
    func test_ShimmerGradient_init() {
        let gradient = ShimmerGradient(start: .red, middle: .white, end: .blue, direction: .horizontal)
        XCTAssertEqual(gradient.start, .red)
        XCTAssertEqual(gradient.middle, .white)
        XCTAssertEqual(gradient.end, .blue)
        XCTAssertEqual(gradient.direction, .horizontal)
    }

    func test_ShimmerGradient() {
        XCTAssertEqual(ShimmerGradient.shimmerGradient.start,  UIColor.white.withAlphaComponent(0.0))
        XCTAssertEqual(ShimmerGradient.shimmerGradient.middle, UIColor.white.withAlphaComponent(0.3))
        XCTAssertEqual(ShimmerGradient.shimmerGradient.end, UIColor.white.withAlphaComponent(0.0))
        XCTAssertEqual(ShimmerGradient.shimmerGradient.direction, .diagonal)
    }

    func test_ShimmerGradient_WithShimmerOpacity() {
        let gradient = ShimmerGradient().withShimmerOpacity(0.5, with: .diagonal)
        XCTAssertEqual(gradient.start, UIColor.white.withAlphaComponent(0.0))
        XCTAssertEqual(gradient.middle, UIColor.white.withAlphaComponent(0.5))
        XCTAssertEqual(gradient.end, UIColor.white.withAlphaComponent(0.0))
        XCTAssertEqual(gradient.direction, .diagonal)
    }

    // MARK - ShimmerGradientView
}
