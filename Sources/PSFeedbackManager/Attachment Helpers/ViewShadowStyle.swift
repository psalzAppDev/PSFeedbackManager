//
//  ViewShadowStyle.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 23.09.21.
//
//  Originally created by Daniel Saidi on 2020-03-05.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
**PSSwiftUIKit**: This struct represents a style with properties that matches the SwiftUI's `shadow`
  modifier.

 You can use the style properties together with the standard modifier or use the `shadow(_ style:)`
 `View` extension.

 You can specify your own standard styles by creating static, calculated `ShadowStyle` extension properties.
 */
struct ViewShadowStyle {

    init(
        color: Color? = nil,
        radius: CGFloat = 0,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) {

        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }

    let color: Color?
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

extension ViewShadowStyle {

    /// This style can be used when a style is required, but no shadow should be applied.
    static let none = ViewShadowStyle(color: .clear)

    /// This style represents a badge that's attached to a view, but in a separate layer and with a little blur.
    static var badge = ViewShadowStyle(radius: 1, y: 1)

    /// This style represents a shadow that is cast from a view that is elevated above the parent view.
    static var elevated = ViewShadowStyle(radius: 3, x: 0, y: 2)

    /// This style represents a badge that's attached to a view, but unlike a badge, it doesn't have any blur.
    static var sticker = ViewShadowStyle(radius: 1, y: 1)
}

extension View {

    /**
      **PSSwiftUIKit**: Applies a `ShadowStyle` to the view.

      The result is identical to when using the standard view modifier directly.
     */
    @ViewBuilder
    func shadow(_ style: ViewShadowStyle) -> some View {

        if let color = style.color {

            shadow(
                color: color,
                radius: style.radius,
                x: style.x,
                y: style.y
            )

        } else {

            shadow(radius: style.radius, x: style.x, y: style.y)
        }
    }
}

#Preview {

    struct Preview: View {

        @State
        private var isItemElevated = false

        var item: some View {

            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
        }

        var body: some View {

            VStack(spacing: 20) {

                item
                    .shadow(.none)

                item
                    .shadow(.badge)

                #if os(iOS)
                item
                    .onTapGesture(perform: toggleElevated)
                    .shadow(isItemElevated ? .elevated : .badge)
                #endif

                item
                    .shadow(.elevated)
            }
            .padding()
            .background(Color.gray.opacity(0.4))
        }

        func toggleElevated() {

            withAnimation {
                isItemElevated.toggle()
            }
        }
    }

    return Preview()
}
