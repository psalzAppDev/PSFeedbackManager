//
//  FeedbackManager+Configuration.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import SwiftUI

public extension FeedbackManagerView {

    struct Configuration {

        public var recipients: [String]
        public var title: String
        public var sendButtonTitle: String
        public var cancelButtonTitle: String

        public init(
            recipients: [String],
            title: String? = nil,
            sendButtonTitle: String? = nil,
            cancelButtonTitle: String? = nil
        ) {

            self.recipients = recipients
            
            self.title = title ?? FeedbackManagerView.Strings.title
            
            self.sendButtonTitle = sendButtonTitle
                ?? FeedbackManagerView.Strings.sendButtonTitle
            
            self.cancelButtonTitle = cancelButtonTitle
                ?? FeedbackManagerView.Strings.cancelButtonTitle
        }
    }
}
