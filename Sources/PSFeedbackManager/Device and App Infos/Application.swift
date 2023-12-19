//
//  Application.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import Foundation

struct Application {

    static var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    static var build: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    static var completeAppVersion: String {
        "\(Application.version) (\(Application.build))"
    }

    static var displayName: String {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    static var name: String {
        Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
