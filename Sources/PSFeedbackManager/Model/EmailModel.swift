//
//  EmailModel.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct EmailModel {

    var subject = ""
    var body = ""
    var attachments: [AttachmentData] = []
    var recipients: [String] = []

    #if canImport(UIKit)
    let deviceModel = UIDevice.modelName
    let deviceOS = UIDevice().systemVersion
    #else
    let deviceModel = "Mac"
    let deviceOS = ProcessInfo.processInfo.operatingSystemVersionString
    #endif

    let appName = Application.name
    let appVersion = Application.version
    let appBuild = Application.build
}

struct AttachmentData {

    let data: Data
    let mimeType: String
    let fileName: String
}

#if canImport(UIKit)
typealias NativeImage = UIImage
#elseif canImport(AppKit)
typealias NativeImage = NSImage
#endif
