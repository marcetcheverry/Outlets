//
//  AppDelegate.swift
//  Outlets
//
//  Created by Marc on 5/31/16.
//  Copyright © 2016 Tap Light Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let components = url.pathComponents
        if url.pathComponents.count > 0 {
            if let host = url.host,
                let outlet = UInt(host),
                let statusRawValue = components.last,
                let status = Outlets.status(rawValue: statusRawValue),
                let viewController = window?.rootViewController as? ViewController {
                viewController.toggleOutlet(number: outlet, status: status)
                return true
            }
        }

        assertionFailure("Could not parse '\(url)'")
        return false
    }
}
