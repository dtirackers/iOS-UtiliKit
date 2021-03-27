//
//  SkeletonViewsExamplesViewController.swift
//  UtiliKit-iOSExample
//
//  Created by Eugene Heckert on 2/24/21.
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import UIKit

public class ShimmerStackView: UIStackView, Shimmer {
    public var shimmerView: ShimmerGradientView?
}

class SkeletonViewsExamplesViewController: UIViewController {


    @IBOutlet var containerView: ShimmerStackView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentViews: [UIView]!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applySkeletons()
        applyShimmer()
    }

    @IBAction func applySkeletons(_ sender: Any) {
        applySkeletons()
    }

    @IBAction func removeSkeletons(_ sender: Any) {
        loadContent()
    }
    @IBAction func applyShimmerAction(_ sender: Any) {
        applyShimmer()
    }
    @IBAction func removeShimmerAction(_ sender: Any) {
        containerView.removeShimmer()
    }
}

// MARK: - Private
private extension SkeletonViewsExamplesViewController {

    func applySkeletons() {
        imageView.applySkeleton()
        nameLabel.applySkeleton()
        dateLabel.applySkeleton()
        contentViews.forEach { $0.applySkeleton() }
    }

    func applyShimmer() {
        containerView.applyShimmer(with: ShimmerAnimation.init(with: 0.75))
    }

    func loadContent() {
        imageView.image = #imageLiteral(resourceName: "placeHolder")
        imageView.removeSkeleton()

        nameLabel.text = "Name"
        nameLabel.removeSkeleton()

        dateLabel.text = "Date"
        dateLabel.removeSkeleton()

        contentViews.forEach { $0.removeSkeleton(withBackground: .black) }
    }
}
