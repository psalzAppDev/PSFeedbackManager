//
//  ListCard.swift
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
struct ListCard<Content: View>: View {

    init(cornerRadius: Double = 8, @ViewBuilder content: @escaping ContentBuilder) {
        
        self.cornerRadius = cornerRadius
        self.content = content
    }

    typealias ContentBuilder = () -> Content

    @ViewBuilder
    private let content: ContentBuilder

    private let cornerRadius: Double

    var body: some View {

        content()
            .background(Color.primary.colorInvert())
            .cornerRadius(cornerRadius)
            .listCardShadow()
    }
}

extension View {

    func listCardShadow() -> some View {

        self
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
            ListCard {
                Color.red
                    .frame(width: 200, height: 200)
            }
        }
    )
    .padding(50)
    .background(Color.gray)
    .cornerRadius(20)
}
