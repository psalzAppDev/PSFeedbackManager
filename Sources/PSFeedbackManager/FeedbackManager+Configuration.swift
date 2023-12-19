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
