//
//  Card.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 20.12.23.
//

import SwiftUI

struct Card<Content: View>: View {

    init(
        cornerRadius: Double = 8,
        @ViewBuilder content: @escaping () -> Content
    ) {

        self.cornerRadius = cornerRadius
        self.content = content
    }

    @ViewBuilder
    private let content: () -> Content

    private let cornerRadius: Double

    var body: some View {

        content()
            .background(Color.primary.colorInvert())
            .cornerRadius(cornerRadius)
            .shadow(
                color: .black.opacity(0.2),
                radius: 2,
                x: 0,
                y: 2
            )
    }
}

#Preview {

    Button(
        action: {},
        label: {
            Card {
                Color.red
                    .frame(width: 200, height: 200)
            }
        }
    )
    .padding(50)
    .background(Color.gray)
    .cornerRadius(20)
}
