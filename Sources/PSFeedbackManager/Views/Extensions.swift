//
//  Extensions.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 20.12.23.
//

import SwiftUI

extension View {

    #if !targetEnvironment(macCatalyst) && !os(visionOS) && !os(macOS)
    func keyboardDoneButton(action: @escaping () -> Void) -> some View {

        self
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {

                    Spacer()

                    Button(
                        action: action,
                        label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    )
                    .foregroundStyle(Color.accentColor)
                }
            }
    }
    #endif
}
