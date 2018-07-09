//
//  ViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/9/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**
 a very basic view controller implementation
 **/
class ViewController: UIViewController {
    // called when the view is initially sized and ready to show (but not yet showing). Can do UI size calculations and layout here
    override func viewDidLoad() {
        super.viewDidLoad() // always call your supers
        view.backgroundColor = .red // omit anything you don't absolutely need. this is otherwise written as `UIColor.red`. `UIColor` is implicit
        title = "App Springboard" // the title only shows up when this view is shown in a navigation controller

        /**
         When a view controller is added to navigation controller the nav controller looks for specific objects in the child
         view controllers. These things include `title` & `navigationItem`. These items determine various attributes about the navigation controller
         like the buttons that show up in the top nav bar.
        **/
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(launchModal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(pushNewView))
    }

    /**
     This is a function that is reachable via selector. To be reachable, it must have a prefixed: `@objc` so the compiler knows to make it available
     to objective-c classes as well. legacy stuff we have to live with. could be worse I guess.
    **/
    @objc func launchModal() {
        /**
         a modally presented view controller slides in from the bottom. good for brief actions taken by the user

         the viewController is wrapped in a navigation controller so we can utilize the navigation bar buttons
        **/
        let nc = UINavigationController(rootViewController: SecondaryViewController())
        present(nc, animated: true, completion: nil)
    }

    @objc func pushNewView() {
        /**
         here, we're pushing a view controller onto the view controller's stack. we don't need to wrap this view controller
         in a navigation controller because we're adding it to the existing one. The default animation is to have it slide in from the right.
         it also does a bunch of other animations for free that transition the title and buttons in the nav bar.
        **/
        navigationController?.pushViewController(SecondaryViewController(), animated: true)
    }
}
