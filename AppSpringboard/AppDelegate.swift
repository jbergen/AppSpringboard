//
//  AppDelegate.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/9/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**
 This class deals with the lifecycle of the app. The UIApplicaiton delegate gives you hooks into many different situations that you may
 need to handle. e.g. app going in to background, push events, responding to shortcuts etc.
 **/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /**
         This is the goo that we need to get the app to show a view without Interface Builder (IB). I basically copy/paste this
         into every single one of my projects.
        **/
        let win = UIWindow()
        win.frame = UIScreen.main.bounds

        /**
         Here I'm setting the root view controller to be a navigation controller. A nav controller is at the heart of the vast majority of apps

         OPTION + CLICK on `navigationController` to see info about the property
         COMMAND + CLICK to see more options like navigate to that class
        **/
        win.rootViewController = ApplicationController.shared.navigationController
        win.makeKeyAndVisible()
        window = win

        return true
    }
}
