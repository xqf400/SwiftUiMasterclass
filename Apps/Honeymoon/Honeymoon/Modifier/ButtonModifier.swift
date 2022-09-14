//
//  ButtonModifier.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 14.09.22.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.headline)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                Capsule().fill(.yellow)
            )
            .foregroundColor(.white)
    }
}


