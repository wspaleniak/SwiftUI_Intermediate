//
//  RotationGestureExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 13/07/2024.
//



// MARK: - NOTES

// MARK: 3 - How to use RotationGesture in SwiftUI
///
/// - gest obracania
/// - rzadko używany w produkcyjnych aplikacjach
/// - używamy ogólnego modyfikatora `.gesture`
/// - jako argument podajemy `RotationGesture()`
/// - modyfikator `.onChanged` wywoływany jest w trakcie wykonywania gestu i dostarcza wartość aktualnego obrotu
/// - modyfikator `.onEnded` wywoływany po zakończeniu gestu - zwraca ostatnią wartość
/// - możemy w Preview używać gestów dla dwóch palcy przytrzymując klawisz `Option`



// MARK: - CODE

import SwiftUI

struct RotationGestureExample: View {
    
    // MARK: - Properties
    
    @State private var currentAngle: Angle = .zero
    
    // MARK: - Body
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(30)
            .background(.yellow)
            .clipShape(Capsule())
            .rotationEffect(currentAngle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        currentAngle = value
                    }
                    .onEnded { _ in
                        withAnimation {
                            currentAngle = .zero
                        }
                    }
            )
    }
}

// MARK: - Preview

#Preview {
    RotationGestureExample()
}
