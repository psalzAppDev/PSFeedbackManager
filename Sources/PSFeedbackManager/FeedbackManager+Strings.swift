//
//  FeedbackManager+Strings.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import Foundation

struct Strings {

    static let alertMailUnavailableTitle = NSLocalizedString(
        "alert.mail.title",
        bundle: .module,
        value: "This device can't send emails",
        comment: ""
    )

    static let alertMailUnavailableMessageFormat = NSLocalizedString(
        "alert.mail.message",
        bundle: .module,
        value: "You can reach me at %@",
        comment: "E-mail address"
    )

    static let title = NSLocalizedString(
        "title",
        bundle: .module,
        value: "Contact Us",
        comment: "Title"
    )

    static let sendButtonTitle = NSLocalizedString(
        "sendButton.title",
        bundle: .module,
        value: "Send",
        comment: "SendButton Title"
    )

    static let cancelButtonTitle = NSLocalizedString(
        "cancelButton.title",
        bundle: .module,
        value: "Cancel",
        comment: "CancelButton Title"
    )

    static let okAction = NSLocalizedString(
        "action.ok",
        bundle: .module,
        value: "OK",
        comment: "Ok action"
    )

    static let textViewPlaceholder = NSLocalizedString(
        "topic.textView.placeholder",
        bundle: .module,
        value: "Describe your question here.",
        comment: "Topic TextView Placeholder"
    )

    static let textViewPlaceholderWithSelection = NSLocalizedString(
        "topic.textView.placeholder.withSelection",
        bundle: .module,
        value: "Describe your %@ here.",
        comment: "Topic TextView Placeholder With Selection"
    )

    static let editedNotification = NSLocalizedString(
        "editedNotification",
        bundle: .module,
        value: "Edited - Tap \"Cancel\" to dismiss",
        comment: "EditedNotification"
    )

    static let topicSelectTitle = NSLocalizedString(
        "topic.select.title",
        bundle: .module,
        value: "Select topic",
        comment: "Topic Select Title"
    )

    static let attachmentsAttachTitle = NSLocalizedString(
        "attachments.attach.title",
        bundle: .module,
        value: "Attach Photo",
        comment: "Attachments Attach Title"
    )

    static let attachmentsDelete = NSLocalizedString(
        "attachments.delete",
        bundle: .module,
        value: "Delete attachment",
        comment: "Attachments Delete"
    )

    static let attachmentsAttachmentTitleWithIndex = NSLocalizedString(
        "attachments.attachment.titleWithIndex",
        bundle: .module,
        value: "Attachment %d",
        comment: "Attachments Attachment Title With Index"
    )

    static let deviceInfoDeviceTitle = NSLocalizedString(
        "deviceInfo.device.title",
        bundle: .module,
        value: "Device",
        comment: "DeviceInfo Device Title"
    )

    static let deviceInfoSystemTitle = NSLocalizedString(
        "deviceInfo.system.title",
        bundle: .module,
        value: "iOS",
        comment: "DeviceInfo System Title"
    )

    static let appInfoNameTitle = NSLocalizedString(
        "appInfo.name.title",
        bundle: .module,
        value: "Name",
        comment: "AppInfo Name Title"
    )

    static let appInfoVersionTitle = NSLocalizedString(
        "appInfo.version.title",
        bundle: .module,
        value: "Version",
        comment: "App Info Version Title"
    )

    static let appInfoBuildTitle = NSLocalizedString(
        "appInfo.build.title",
        bundle: .module,
        value: "Build",
        comment: "App Info Build Title"
    )

    static let topicSelectionQuestion = NSLocalizedString(
        "topic.selection.question",
        bundle: .module,
        value: "Question",
        comment: "Topic Selection Question"
    )

    static let topicSelectionRequest = NSLocalizedString(
        "topic.selection.request",
        bundle: .module,
        value: "Request",
        comment: "Topic Selection Request"
    )

    static let topicSelectionBugReport = NSLocalizedString(
        "topic.selection.bugReport",
        bundle: .module,
        value: "Bug Report",
        comment: "Topic Selection Bug Report"
    )

    static let topicSelectionOther = NSLocalizedString(
        "topic.selection.other",
        bundle: .module,
        value: "Other",
        comment: "Topic Selection Other"
    )

    static let headerTopic = NSLocalizedString(
        "header.topic",
        bundle: .module,
        value: "Topic",
        comment: "Header Topic"
    )

    static let headerAttachments = NSLocalizedString(
        "header.attachments",
        bundle: .module,
        value: "Attchments",
        comment: "Header Attachments"
    )

    static let headerDeviceInfo = NSLocalizedString(
        "header.deviceInfo",
        bundle: .module,
        value: "Device Info",
        comment: "Header Device Info"
    )

    static let headerAppInfo = NSLocalizedString(
        "header.appInfo",
        bundle: .module,
        value: "App Info",
        comment: "Header App Info"
    )
}
