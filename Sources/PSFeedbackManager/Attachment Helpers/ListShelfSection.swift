//
//  ListShelfSection.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import SwiftUI

/**
 Adapted from SwiftUIKit.

 Here is the Github [Link](https://github.com/danielsaidi/SwiftUIKit)

 License:

 MIT License

 Copyright (c) 2020-2024 Daniel Saidi

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
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

                        ListCard { Color.red }

                        ListCard { Color.green }

                        ListCard { Color.blue }
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
