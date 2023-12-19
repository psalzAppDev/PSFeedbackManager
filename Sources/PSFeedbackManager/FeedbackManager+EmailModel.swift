//
//  FeedbackManager+EmailModel.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import UIKit
import PSLuminous

class EmailModel {

    var subject = ""
    var body = ""
    var attachments = [UIImage]()

    let deviceModel = Luminous.Hardware.Device.current.model
    let deviceOS = Luminous.Hardware.systemVersion.stringValue

    let appName = Luminous.Application.name
    let appVersion = Luminous.Application.version
    let appBuild = Luminous.Application.build
}
