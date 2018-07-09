//
//  ApplicationController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/9/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**
 I don't like to use the singleton pattern a lot, but here's one case where I do. This class can be
 used to get/set application state, update navigation, or respond to system events without complicated
 logic drilling into the navigation structure of your app from an arbitrary point.
**/
class ApplicationController {
    // The shared singleton object
    static let shared = ApplicationController()

    /**
     This navigation controller is base view for every other view controller in the app.
     Understanding how navigation controllers work and what they can and can't do is key to a happy
     developer and app. You can definitely push the envelope, but understanding this first is crucial.

     https://developer.apple.com/documentation/uikit/uinavigationcontroller
    **/
    let navigationController: UINavigationController

    /**
     In this init we're creating a new instance of ViewController and setting it as the rootViewController
     of the shared navigation controller. We set `navigationController` in the init because it must be non-nil
     once `init` completes.
    **/
    init() {
        let vc = ViewController()
        navigationController = UINavigationController(rootViewController: vc)
    }
}
