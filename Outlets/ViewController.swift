//
//  ViewController.swift
//  Outlets
//
//  Created by Marc on 5/31/16.
//  Copyright © 2016 Tap Light Software. All rights reserved.
//

import UIKit

private enum Defaults: String {
    case initialAlertAboutLongPressPresented = "initialAlertAboutLongPressPresented"
}

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !UserDefaults.standard.bool(forKey: Defaults.initialAlertAboutLongPressPresented.rawValue) {
            let alertController = UIAlertController(title: NSLocalizedString("Hint", comment: ""), message: NSLocalizedString("Tap and hold anywhere on the screen to toggle all outlets.", comment: ""), preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true) {
                UserDefaults.standard.set(true, forKey: Defaults.initialAlertAboutLongPressPresented.rawValue)
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func touchedOn(_ sender: UIButton) {
        assert(sender.tag > 0)
        toggleOutlet(number: UInt(sender.tag), status: .on)
    }

    @IBAction func touchedOff(_ sender: UIButton) {
        assert(sender.tag > 0)
        toggleOutlet(number: UInt(sender.tag), status: .off)
    }

    @IBAction func touchedLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let alertController = UIAlertController(title: NSLocalizedString("Toggle All Outlets", comment: ""), message: nil, preferredStyle: .actionSheet)

            let actionOn = UIAlertAction(title: NSLocalizedString("On", comment: ""), style: .default) { action in
                self.toggleOutlet(number: Outlets.allOutletsNumber, status: .on)
            }

            let actionOff = UIAlertAction(title: NSLocalizedString("Off", comment: ""), style: .destructive) { action in
                self.toggleOutlet(number: Outlets.allOutletsNumber, status: .off)
            }

            let actionCancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(actionOn)
            alertController.addAction(actionOff)
            alertController.addAction(actionCancel)

            if alertController.popoverPresentationController != nil {
                let point = sender.location(in: view)
                alertController.popoverPresentationController!.sourceView = view
                alertController.popoverPresentationController!.sourceRect = CGRect(x: point.x, y: point.y, width: 1, height: 1)
            }

            present(alertController, animated: true, completion: nil)
        }
    }

    func toggleOutlet(number: UInt, status: Outlets.status) {
        func presentError(_ error: Error) {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }

        executeToggleOutletTask(number: number, status: status) { (error) in
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let error = error {
                    presentError(error)
                }
            }
        }

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}
