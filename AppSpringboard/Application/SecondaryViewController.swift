//
//  SecondaryViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/9/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

class SecondaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "SECONDARY"

        /**
         in order to use this in either a modal or pushed context, we're only adding the cancel button if the view controller
         has a non-nil `presentingViewController` which indicates that it was probably presented modally. In most real applications
         each view controller will only be displayed one way and don't need this type of conditional
        **/
        if presentingViewController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        }
    }

    @objc func cancel() {
        // how you exit out of a modal which slides it down vertically by default
        dismiss(animated: true, completion: nil)
    }
}
