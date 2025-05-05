//
//  VisualEffectModifierExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 25/10/2024.
//



// MARK: - NOTES

// MARK: 33 - How to use VisualEffect ViewModifier SwiftUI
///
/// - modyfikator dostępny od iOS 17
/// - `.visualEffect` jest domknięciem z argumentami `content` typu `EmptyVisualEffect` oraz `proxy` typu `GeometryProxy`
/// - nie wszystkie modyfikatory możemy użyć na zmiennej `content` ponieważ nie jest to `View`



// MARK: - CODE

import SwiftUI

struct VisualEffectModifierExample: View {
    
    // MARK: - Properties
    
    @State
    private var showSpacer: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(.yellow)
                .visualEffect { content, proxy in
                    content
                        // .grayscale(proxy.size.width >= 200 ? 1 : 0)
                        .grayscale(proxy.frame(in: .global).minY < 200 ? 1 : 0)
                }
            if showSpacer { Spacer() }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
        .onTapGesture { showSpacer.toggle() }
        .animation(.default, value: showSpacer)
    }
}

// MARK: - Preview

#Preview {
    VisualEffectModifierExample()
}
