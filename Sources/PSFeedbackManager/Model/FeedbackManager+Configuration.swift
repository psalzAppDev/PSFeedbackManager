//
//  FeedbackManager+Configuration.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import SwiftUI

public extension FeedbackManagerView {

    struct Configuration {

        public var isModal: Bool

        public var recipients: [String]
        public var title: String
        public var sendButtonTitle: String
        public var cancelButtonTitle: String

        /**
         The configuration for `FeedbackManagerView`.

         Providing at least one recipient email address is mandatory.

         - Parameters:
            - isModal: Whether the view is shown modally, i.e. as a sheet. Default is `true`.
            - recipients: The list of recipient email addresses.
            - title: Optional custom title of the view. If `nil`, the standard localized title will be shown.
            - sendButtonTitle: Optional custom title for the send button. If `nil`, the standard localized title will be shown.
            - cancelButtonTitle: Optional custom title for the cancel button. If `nil`, the standard localized title will be shown.
         */
        public init(
            isModal: Bool = true,
            recipients: [String],
            title: String? = nil,
            sendButtonTitle: String? = nil,
            cancelButtonTitle: String? = nil
        ) {

            self.isModal = isModal

            self.recipients = recipients
            
            self.title = title ?? Strings.title
            
            self.sendButtonTitle = sendButtonTitle
                ?? Strings.sendButtonTitle
            
            self.cancelButtonTitle = cancelButtonTitle
                ?? Strings.cancelButtonTitle
        }
    }
}
