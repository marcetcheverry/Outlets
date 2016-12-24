//
//  Network.swift
//  Outlets
//
//  Created by Marc on 12/23/16.
//  Copyright © 2016 Tap Light Software. All rights reserved.
//

import Foundation

/// Toggles an outlet on an RFOutlet instance.
func executeToggleOutletTask(number: UInt, status: Outlets.status, completion: @escaping (Error?) -> Void) {
    if let URL = URL(string: Outlets.endpoint) {
        var request = URLRequest(url: URL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: Outlets.timeout)
        let parameters = "outletId=\(number)&outletStatus=\(status.rawValue)"
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(error)
        }

        task.resume()
    } else {
        completion(NSError(domain: "Outlets", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Could not construct URL for endpoint", comment: "")]))
    }
}
