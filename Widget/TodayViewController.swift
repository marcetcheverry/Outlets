//
//  TodayViewController.swift
//  Widget
//
//  Created by Marc on 5/31/16.
//  Copyright © 2016 Tap Light Software. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var stackView4: UIStackView!
    @IBOutlet weak var stackView5: UIStackView!
    @IBOutlet weak var stackViewAll: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        updatedInterfaceBasedOnDisplayMode()
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        updatedInterfaceBasedOnDisplayMode(maxSize: maxSize)
    }

    private func updatedInterfaceBasedOnDisplayMode(maxSize: CGSize? = nil) {
        if extensionContext?.widgetActiveDisplayMode == .compact {
            stackView1.isHidden = true
            stackView2.isHidden = true
            stackView3.isHidden = true
            stackView4.isHidden = true
            stackView5.isHidden = true
            stackViewAll.isHidden = false
            let targetSize = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)

            if maxSize != nil &&
                targetSize.width <= maxSize!.width &&
                targetSize.height <= maxSize!.height {
                preferredContentSize = targetSize
            } else {
                preferredContentSize = maxSize ?? targetSize
            }
        } else if extensionContext?.widgetActiveDisplayMode == .expanded {
            stackView1.isHidden = false
            stackView2.isHidden = false
            stackView3.isHidden = false
            stackView4.isHidden = false
            stackView5.isHidden = false
            stackViewAll.isHidden = false
            preferredContentSize = view.systemLayoutSizeFitting(UILayoutFittingExpandedSize)
        }
    }

    @IBAction func touchedOn(_ sender: UIButton) {
        toggleOutlet(number: sender.tag, status: .on)
    }

    @IBAction func touchedOff(_ sender: UIButton) {
        toggleOutlet(number: sender.tag, status: .off)
    }

    private func toggleOutlet(number: Int, status: Outlets.status) {
        assert(number > 0)
        extensionContext?.open(URL(string: "outlets://\(number)/\(status.rawValue)")!, completionHandler: nil)
    }
}
