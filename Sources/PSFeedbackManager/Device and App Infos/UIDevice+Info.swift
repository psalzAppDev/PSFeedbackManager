//
//  UIDevice+Info.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import UIKit

extension UIDevice {

    static let modelName: String = {

        var systemInfo = utsname()

        uname(&systemInfo)

        let machineMirror = Mirror(reflecting: systemInfo.machine)

        let identifier = machineMirror.children.reduce("") { identifier, element in

            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }

            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }()

    static let systemVersionString: String = {
        SystemVersion(withVersion: UIDevice().systemVersion)?.stringValue ?? ""
    }()
}
