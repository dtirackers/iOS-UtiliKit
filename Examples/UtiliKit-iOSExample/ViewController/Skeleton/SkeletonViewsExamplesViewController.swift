//
//  SkeletonViewsExamplesViewController.swift
//  UtiliKit-iOSExample
//
//  Created by Eugene Heckert on 2/24/21.
//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.
//

import UIKit

class SkeletonViewsExamplesViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentViews: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applySkeletions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applySkeletions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applySkeletions()
    }

    @IBAction func applySkeletions(_ sender: Any) {
        applySkeletions()
    }

    @IBAction func removeSkeletions(_ sender: Any) {
        loadContent()
    }
}

// MARK: - Private
private extension SkeletonViewsExamplesViewController {

    func applySkeletions() {
        imageView.applySkeleton()
        nameLabel.applySkeleton()
        dateLabel.applySkeleton()
        contentViews.forEach { $0.applySkeleton() }
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
