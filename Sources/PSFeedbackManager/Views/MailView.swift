//
//  MailView.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

#if canImport(UIKit)

import SwiftUI
import MessageUI

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

/**
 Wraps the `MFMailComposeViewController`in a SwiftUI view.

 [Source](https://swiftuirecipes.com/blog/send-mail-in-swiftui)
 */
struct MailView: UIViewControllerRepresentable {

    @Environment(\.dismiss)
    private var dismiss

    @Binding
    var data: EmailModel

    let callback: MailViewCallback

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding
        var data: EmailModel

        let callback: MailViewCallback

        let dismissAction: () -> Void

        init(
            data: Binding<EmailModel>,
            callback: MailViewCallback,
            dismissAction: @escaping () -> Void
        ) {
            self._data = data
            self.callback = callback
            self.dismissAction = dismissAction
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {

            if let error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }

            dismissAction()
        }
    }

    func makeCoordinator() -> Coordinator {

        Coordinator(
            data: $data,
            callback: callback,
            dismissAction: { dismiss() }
        )
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {

        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(data.subject)
        vc.setToRecipients(data.recipients)
        vc.setMessageBody(data.body, isHTML: false)

        data.attachments.forEach {
            vc.addAttachmentData(
                $0.data,
                mimeType: $0.mimeType,
                fileName: $0.fileName
            )
        }

        vc.accessibilityElementDidLoseFocus()

        return vc
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController, 
        context: Context
    ) {}

    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}

#endif
