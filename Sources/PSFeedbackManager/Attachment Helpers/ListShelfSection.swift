//
//  ListShelfSection.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//
//  Originally created by Daniel Saidi on 2023-04-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to add a horizontally scrolling shelf to a vertically scrolling list.
 */
struct ListShelfSection<Title: View, Content: View>: View {

    init(
        style: ListShelfSectionStyle = .standard,
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder content: @escaping () -> Content
    ) {

        self.style = style
        self.title = title
        self.content = content
    }

    private let style: ListShelfSectionStyle
    private let shadowSpacing = 50.0

    @ViewBuilder
    private let title: () -> Title

    @ViewBuilder
    private let content: () -> Content

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            title()
                .padding(.horizontal, style.horizontalPadding)
                .padding(.bottom, style.rowTitleSpacing)

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
}

struct ListShelfSectionStyle {

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

    static var standard = ListShelfSectionStyle()
}

#Preview {

    struct Section: View {

        var body: some View {
        
            ListShelfSection(
                title: {
                    EmptyView()
                },
                content: {
                    Group {

                        ListCard(
                            content: { Color.red },
                            contextMenu: {
                                Button("1") {}
                                Button("2") {}
                                Button("3") {}
                            }
                        )

                        ListCard(
                            content: { Color.green },
                            contextMenu: {
                                Button("1") {}
                                Button("2") {}
                                Button("3") {}
                            }
                        )

                        ListCard(
                            content: { Color.blue },
                            contextMenu: {
                                Button("1") {}
                                Button("2") {}
                                Button("3") {}
                            }
                        )
                    }
                    .frame(width: 150, height: 150)
                }
            )
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
