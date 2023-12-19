//
//  ListCard.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//
//  Originally created by Daniel Saidi on 2023-04-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used as a floating card in lists and grids.

 The card can be styled with a corner radius and shadow, and can also be provided with a list of context menu
 items that will be presented when long pressing the card.
 */
struct ListCard<Content: View, ContextMenuView: View>: View {

    init(
        style: ListCardStyle = .standard,
        @ViewBuilder content: @escaping ContentBuilder
    ) where ContextMenuView == EmptyView {

        self.style = style
        self.content = content
        self.contextMenu = { EmptyView() }
    }

    init(
        style: ListCardStyle = .standard,
        @ViewBuilder content: @escaping ContentBuilder,
        @ViewBuilder contextMenu: @escaping ContextMenuBuilder
    ) {

        self.style = style
        self.content = content
        self.contextMenu = contextMenu
    }

    typealias ContentBuilder = () -> Content
    typealias ContextMenuBuilder = () -> ContextMenuView

    private let style: ListCardStyle

    @ViewBuilder
    private let content: ContentBuilder

    @ViewBuilder
    private let contextMenu: ContextMenuBuilder

    var body: some View {

        content()
            #if os(iOS)
            .contentShape(
                .contextMenuPreview,
                RoundedRectangle(cornerRadius: style.cornerRadius)
            )
            #endif
            .background(Color.primary.colorInvert())
            .cornerRadius(style.cornerRadius)
            .contextMenu(menuItems: contextMenu)
            .shadow(style.shadowStyle)
    }
}

struct ListCardStyle {

    init(
        cornerRadius: Double = 8.0,
        shadowStyle: ViewShadowStyle = .listCard
    ) {

        self.cornerRadius = cornerRadius
        self.shadowStyle = shadowStyle
    }

    var cornerRadius: Double
    var shadowStyle: ViewShadowStyle
}

extension ListCardStyle {

    static var standard = ListCardStyle()
}

/// This button style can be used to scale down a ``ListCard``.
struct ListCardButtonStyle: ButtonStyle {

    init(pressedScale: Double = 0.98) {
        self.pressedScale = pressedScale
    }

    var pressedScale: Double

    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
    }
}

extension ButtonStyle where Self == ListCardButtonStyle {

    /**
     The standard list card button style.

     You can change this style to affect the standard global style of the ``ListCard`` button view.
     */
    static var listCard: ListCardButtonStyle { .init() }

    static func listCard(pressedScale: Double) -> ListCardButtonStyle {
        .init(pressedScale: pressedScale)
    }
}

extension ViewShadowStyle {

    static var listCard = ViewShadowStyle(
        color: .black.opacity(0.2),
        radius: 2,
        x: 0,
        y: 2
    )
}

#Preview {

    Button(
        action: {},
        label: {
            ListCard(
                content: {
                    Color.red
                        .frame(width: 200, height: 200)
                },
                contextMenu: {}
            )
        }
    )
    .buttonStyle(.listCard)
    .padding(50)
    .background(Color.gray)
    .cornerRadius(20)
}
