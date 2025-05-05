//
//  LongPressGestureExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 30/06/2024.
//



// MARK: - NOTES

// MARK: 1 - How to use LongPressGesture in SwiftUI
///
/// - jest to gest dłuższego przytrzymania palcem na ekranie
/// - używamy modyfikatora `.onLongPressGesture`
/// - `minimumDuration` - czas po którym wykona się akcja gestu
/// - `maximumDistance` - dystans jaki user może przesunąć palcem podczas trwania gestu bez anulowania go
/// - `perform` - akcja gestu
/// - `onPressingChanged` - stan gestu - gdy nic sie nie dzieje jest na `false` - gdy klikniemy i trzymamy, to zmienia się na `true` - gdy minie określony czas czyli `minimumDuration` to wraca na `false`



// MARK: - CODE

import SwiftUI

struct LongPressGestureExample: View {
    
    // MARK: - Properties
    
    @State private var isSuccess: Bool = false
    
    @State private var progressComplete: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(height: 40)
                .frame(maxWidth: progressComplete ? .infinity : .zero)
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipShape(Capsule())
                .overlay {
                    Text(isSuccess ? "Completed :)" : "Not completed :(")
                        .font(.footnote)
                }
                .background(
                    Capsule().fill(.gray.opacity(0.3))
                )
                .padding()
                .onLongPressGesture(
                    minimumDuration: 3,
                    maximumDistance: 10
                ) {
                    isSuccess = true
                    progressComplete = true
                } onPressingChanged: { state in
                    withAnimation(.linear(duration: state ? 3 : 0.3)) {
                        progressComplete = state
                    }
                }
            
            Button("RESET PROGRESS") {
                withAnimation(.spring) { progressComplete = false }
                isSuccess = false
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LongPressGestureExample()
}
