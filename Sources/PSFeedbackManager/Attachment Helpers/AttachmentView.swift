//
//  AttachmentView.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 20.12.23.
//

import SwiftUI

/**
 Displays the attached images in a horizontal scroll view as cards with rounded corners and shadow.

 Based on **SwiftUIKit**.

 Here is the Github [Link](https://github.com/danielsaidi/SwiftUIKit).
 */
struct AttachmentView<Content: View>: View {

    init(
        style: AttachmentViewStyle = .standard,
        @ViewBuilder content: @escaping () -> Content
    ) {

        self.style = style
        self.content = content
    }

    private let style: AttachmentViewStyle
    private let shadowSpacing = 50.0

    @ViewBuilder
    private let content: () -> Content

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            LazyHStack(spacing: style.rowItemSpacing) {
                content()
            }
            .padding(.vertical, shadowSpacing)
            .padding(.horizontal, style.horizontalPadding)
        }
        .padding(.vertical, -shadowSpacing)
        .padding(.bottom, style.rowSpacing)
    }
}

struct AttachmentViewStyle {

    init(
        horizontalPadding: Double = 16,
        rowSpacing: Double = 16,
        rowTitleSpacing: Double = 10,
        rowItemSpacing: Double = 16
    ) {

        self.horizontalPadding = horizontalPadding
        self.rowSpacing = rowSpacing
        self.rowTitleSpacing = rowTitleSpacing
        self.rowItemSpacing = rowItemSpacing
    }

    var horizontalPadding: Double
    var rowSpacing: Double
    var rowTitleSpacing: Double
    var rowItemSpacing: Double

    static let standard = AttachmentViewStyle()
}

#Preview {

    struct Section: View {

        var body: some View {

            AttachmentView {
                Group {
                    Card { Color.red }
                    Card { Color.green }
                    Card { Color.blue }
                }
                .frame(width: 150, height: 150)
            }
        }
    }

    struct Preview: View {

        var body: some View {
            ScrollView(.vertical) {

                VStack {
                    Section()
                    Section()
                    Section()
                }
            }
        }
    }

    return Preview()
}
