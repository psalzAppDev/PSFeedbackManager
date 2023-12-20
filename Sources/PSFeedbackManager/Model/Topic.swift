//
//  Topic.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 20.12.23.
//

import Foundation

enum Topic: CaseIterable, Identifiable {

    var id: String { name }

    case question
    case request
    case bugReport
    case other

    var symbolName: String {

        switch self {

        case .question:
            "questionmark.circle.fill"

        case .request:
            "info.circle.fill"

        case .bugReport:
            "ant.circle.fill"

        case .other:
            "ellipsis.circle.fill"
        }
    }

    var name: String {

        switch self {

        case .question:
            Strings.topicSelectionQuestion

        case .request:
            Strings.topicSelectionRequest

        case .bugReport:
            Strings.topicSelectionBugReport

        case .other:
            Strings.topicSelectionOther
        }
    }
}
