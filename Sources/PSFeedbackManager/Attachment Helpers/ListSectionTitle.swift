//
//  ListSectionTitle.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 18.09.23.
//
//  Originally created by Daniel Saidi on 2021-10-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct ListSectionTitle: View {

    init(_ text: String, withInsets: Bool = false) {

        self.text = text
        self.applyInsets = withInsets
    }

    private let text: String
    private let applyInsets: Bool

    var body: some View {

        Text(text.uppercased())
            .foregroundColor(.secondary)
            .font(.footnote)
            .withGroupedListSectionHeaderInsets(if: applyInsets)
    }
}

private extension View {

    @ViewBuilder
    func withGroupedListSectionHeaderInsets(if condition: Bool) -> some View {

        if condition {

            self
                .padding(.leading)
                .padding(.top, -3)

        } else {
            self
        }
    }
}

#Preview {
    List {
        Section(
            content: {
                ListSectionTitle("Foo bar")
            },
            header: {
                Text("Foo bar")
            }
        )
    }
}
