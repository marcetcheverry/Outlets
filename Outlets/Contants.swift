//
//  Contants.swift
//  Outlets
//
//  Created by Marc on 12/23/16.
//  Copyright © 2016 Tap Light Software. All rights reserved.
//

import Foundation

struct Outlets {
    /// The RFOutlet toggle endpoint: https://github.com/timleland/rfoutlet
    static let endpoint = "http://raspberrypi.local/rfoutlet/toggle.php"
    /// Make sure you set a high enough timeout to handle toggling outlets at once
    static let timeout: TimeInterval = 10
    /// The virtual outlet number to toggle all outlets
    static let allOutletsNumber: UInt = 6

    enum status: String {
        case on = "on"
        case off = "off"
    }
}
