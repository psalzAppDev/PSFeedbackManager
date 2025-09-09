//
//  Strings.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import Foundation

struct Strings {

    static let alertMailUnavailableTitle = String(
        localized: "alert.mail.title",
        defaultValue: "This device can't send emails",
        bundle: #bundle,
        comment: ""
    )

    static let alertMailUnavailableMessageFormat = String(
        localized: "alert.mail.message",
        defaultValue: "You can reach us at %@",
        bundle: #bundle,
        comment: "E-mail address"
    )

    static let title = String(
        localized: "title",
        defaultValue: "Contact Us",
        bundle: #bundle,
        comment: "Title"
    )

    static let sendButtonTitle = String(
        localized: "sendButton.title",
        defaultValue: "Send",
        bundle: #bundle,
        comment: "SendButton Title"
    )

    static let cancelButtonTitle = String(
        localized:  "cancelButton.title",
        defaultValue: "Cancel",
        bundle: #bundle,
        comment: "CancelButton Title"
    )

    static let okAction = String(
        localized: "action.ok",
        defaultValue: "OK",
        bundle: #bundle,
        comment: "Ok action"
    )

    static let textViewPlaceholder = String(
        localized: "topic.textView.placeholder",
        defaultValue: "Describe your question here.",
        bundle: #bundle,
        comment: "Topic TextView Placeholder"
    )

    static let textViewPlaceholderWithSelection = String(
        localized:  "topic.textView.placeholder.withSelection",
        defaultValue: "Describe your %@ here.",
        bundle: #bundle,
        comment: "Topic TextView Placeholder With Selection"
    )

    static let editedNotification = String(
        localized: "editedNotification",
        defaultValue: "Edited - Tap \"Cancel\" to dismiss",
        bundle: #bundle,
        comment: "EditedNotification"
    )

    static let topicSelectTitle = String(
        localized: "topic.select.title",
        defaultValue: "Select topic",
        bundle: #bundle,
        comment: "Topic Select Title"
    )

    static let attachmentsAttachTitle = String(
        localized:  "attachments.attach.title",
        defaultValue: "Attach Photo",
        bundle: #bundle,
        comment: "Attachments Attach Title"
    )

    static let attachmentsDelete = String(
        localized: "attachments.delete",
        defaultValue: "Delete attachment",
        bundle: #bundle,
        comment: "Attachments Delete"
    )

    static let attachmentsAttachmentTitleWithIndex = String(
        localized:  "attachments.attachment.titleWithIndex",
        defaultValue: "Attachment %d",
        bundle: #bundle,
        comment: "Attachments Attachment Title With Index"
    )

    static let deviceInfoDeviceTitle = String(
        localized: "deviceInfo.device.title",
        defaultValue: "Device",
        bundle: #bundle,
        comment: "DeviceInfo Device Title"
    )

    static let deviceInfoSystemTitle = String(
        localized: "deviceInfo.system.title",
        defaultValue: "iOS",
        bundle: #bundle,
        comment: "DeviceInfo System Title"
    )

    static let appInfoNameTitle = String(
        localized: "appInfo.name.title",
        defaultValue: "Name",
        bundle: #bundle,
        comment: "AppInfo Name Title"
    )

    static let appInfoVersionTitle = String(
        localized: "appInfo.version.title",
        defaultValue: "Version",
        bundle: #bundle,
        comment: "App Info Version Title"
    )

    static let appInfoBuildTitle = String(
        localized: "appInfo.build.title",
        defaultValue: "Build",
        bundle: #bundle,
        comment: "App Info Build Title"
    )

    static let topicSelectionQuestion = String(
        localized: "topic.selection.question",
        defaultValue: "Question",
        bundle: #bundle,
        comment: "Topic Selection Question"
    )

    static let topicSelectionRequest = String(
        localized: "topic.selection.request",
        defaultValue: "Request",
        bundle: #bundle,
        comment: "Topic Selection Request"
    )

    static let topicSelectionBugReport = String(
        localized: "topic.selection.bugReport",
        defaultValue: "Bug Report",
        bundle: #bundle,
        comment: "Topic Selection Bug Report"
    )

    static let topicSelectionOther = String(
        localized:  "topic.selection.other",
        defaultValue: "Other",
        bundle: #bundle,
        comment: "Topic Selection Other"
    )

    static let headerTopic = String(
        localized: "header.topic",
        defaultValue: "Topic",
        bundle: #bundle,
        comment: "Header Topic"
    )

    static let headerAttachments = String(
        localized: "header.attachments",
        defaultValue: "Attachments",
        bundle: #bundle,
        comment: "Header Attachments"
    )

    static let headerDeviceInfo = String(
        localized:  "header.deviceInfo",
        defaultValue: "Device Info",
        bundle: #bundle,
        comment: "Header Device Info"
    )

    static let headerAppInfo = String(
        localized:  "header.appInfo",
        defaultValue: "App Info",
        bundle: #bundle,
        comment: "Header App Info"
    )
}
