//
//  InterfaceController.swift
//  WatchOutlets Extension
//
//  Created by Marc on 10/22/16.
//  Copyright © 2016 Tap Light Software. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    // MARK: - ON
    @IBAction func touchedOn1() {
        toggleOutlet(number: 1, status: .on)
    }

    @IBAction func touchedOn2() {
        toggleOutlet(number: 2, status: .on)
    }

    @IBAction func touchedOn3() {
        toggleOutlet(number: 3, status: .on)
    }

    @IBAction func touchedOn4() {
        toggleOutlet(number: 4, status: .on)
    }

    @IBAction func touchedOn5() {
        toggleOutlet(number: 5, status: .on)
    }

    // MARK: - OFF
    @IBAction func touchedOff1() {
        toggleOutlet(number: 1, status: .off)
    }

    @IBAction func touchedOff2() {
        toggleOutlet(number: 2, status: .off)
    }

    @IBAction func touchedOff3() {
        toggleOutlet(number: 3, status: .off)
    }

    @IBAction func touchedOff4() {
        toggleOutlet(number: 4, status: .off)
    }

    @IBAction func touchedOff5() {
        toggleOutlet(number: 5, status: .off)
    }

    // MARK: - ALL
    @IBAction func toggleAllOff() {
        toggleOutlet(number: Outlets.allOutletsNumber, status: .off)
    }

    @IBAction func toggleAllOn() {
        toggleOutlet(number: Outlets.allOutletsNumber, status: .on)
    }

    // MARK: - NETWORK
    private func toggleOutlet(number: UInt, status: Outlets.status) {
        func presentError(_ error: Error) {
            let action = WKAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: {
                print(error)
            })
            self.presentAlert(withTitle: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert, actions: [action])
        }

        executeToggleOutletTask(number: number, status: status) { (error) in
            if let error = error {
                WKInterfaceDevice.current().play(.failure)
                DispatchQueue.main.async() {
                    presentError(error)
                }
            } else {
                WKInterfaceDevice.current().play(.success)
            }
        }
        WKInterfaceDevice.current().play(.click)
    }
}
