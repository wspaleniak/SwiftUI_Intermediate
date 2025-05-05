//
//  MagnificationGestureExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 02/07/2024.
//



// MARK: - NOTES

// MARK: 2 - How to use MagnificationGesture in SwiftUI
///
/// - jest to gest dwoma palcami który często jest wykorzystywany do zoom in/zoom out
/// - używamy ogólnego modyfikatora `.gesture`
/// - jako argument podajemy `MagnificationGesture()`
/// - modyfikator `.onChanged` wywoływany jest w trakcie wykonywania gestu i dostarcza wartość - dla ściskania jest to od 1.0 do 0.0 - dla rozciągania jest to od 1.0 w górę
/// - modyfikator `.onEnded` wywoływany po zakończeniu gestu - zwraca ostatnią wartość
/// - możemy w Preview używać gestów dla dwóch palcy przytrzymując klawisz `Option`



// MARK: - CODE

import SwiftUI

struct MagnificationGestureExample: View {
    
    // MARK: - Properties
    
    @State private var currentScale: CGFloat = 1.0
    
    // MARK: - Body
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(30)
            .background(.yellow)
            .clipShape(Capsule())
            .scaleEffect(currentScale)
            .animation(.default, value: currentScale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentScale = value
                    }
                    .onEnded { _ in
                        currentScale = 1.0
                    }
            )
    }
}

// MARK: - Preview

#Preview {
    MagnificationGestureExample()
}
