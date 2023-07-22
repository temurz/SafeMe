//
//  DeviceHeader.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation
import UIKit
struct DeviceHeader {
    static var headerArray: [String : String] {
        get {
            [
                "app" : "1",
                "model" : UIDevice.current.model,
                "systemName" : UIDevice.current.systemName,
                "device_id" : UIDevice.current.identifierForVendor?.uuidString ?? "",
                "Accept-Language": AuthApp.shared.language
            ]
        }
    }
}
