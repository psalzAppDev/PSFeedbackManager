//
//  FeedbackManager+EmailModel.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import UIKit

struct EmailModel {

    var subject = ""
    var body = ""
    var attachments: [AttachmentData] = []
    var recipients: [String] = []

    let deviceModel = UIDevice.modelName
    let deviceOS = UIDevice.systemVersionString

    let appName = Application.name
    let appVersion = Application.version
    let appBuild = Application.build
}

struct AttachmentData {

    let data: Data
    let mimeType: String
    let fileName: String
}
