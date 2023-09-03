//
//  Ex+ View.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/03.
//

import SwiftUI
extension View {
    func hideToBool(_ isTrue: Bool) -> some View {
        self.modifier(ViewHideModifier(isTrue: isTrue))
    }
}

struct ViewHideModifier: ViewModifier {
    let isTrue: Bool
    
    func body(content: Content) -> some View {
        if isTrue {
            content
                .hidden()
        } else {
            content
        }
    }
}
