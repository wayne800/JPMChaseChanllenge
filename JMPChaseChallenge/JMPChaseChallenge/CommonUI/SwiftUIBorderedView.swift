//
//  SwiftUIBorderedView.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.green)
            )
    }
}
