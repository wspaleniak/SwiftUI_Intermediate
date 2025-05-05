//
//  DragGestureExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 13/07/2024.
//



// MARK: - NOTES

// MARK: 4 - How to use DragGesture to move, drag, swipe in SwiftUI
///
/// - jest najczęściej używanym z gestów
/// - używamy ogólnego modyfikatora `.gesture`
/// - jako argument podajemy `DragGesture()`
/// - modyfikator `.onChanged` wywoływany jest w trakcie wykonywania gestu i dostarcza wartość typu `Value` która zawiera m.in. `translation` czyli przesunięcie względem ekranu lub `velocity` czyli szybkość gestu
/// - modyfikator `.onEnded` wywoływany po zakończeniu gestu - zwraca ostatnią wartość



// MARK: - CODE

import SwiftUI

struct DragGestureExample: View {
    
    // MARK: - Properties
    
    // MARK: Example
    // @State var offset: CGSize = .zero
    
    // MARK: Tinder example
    // @State var offset: CGSize = .zero
    
    // MARK: Final example
    @State private var startOffset: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentOffset: CGFloat = .zero
    @State private var endOffset: CGFloat = .zero
    
    // MARK: - Body
    
    var body: some View {
        
        // MARK: Example
        // RoundedRectangle(cornerRadius: 20)
        //     .frame(width: 100, height: 100)
        //     .offset(offset)
        //     .animation(.bouncy, value: offset)
        //     .gesture(
        //         DragGesture()
        //             .onChanged { value in
        //                 offset = value.translation
        //             }
        //             .onEnded { value in
        //                 offset = .zero
        //             }
        //     )
        
        // MARK: Tinder example
        // ZStack {
        //     VStack {
        //         Text("\(offset.width)")
        //         Spacer()
        //     }
        //     RoundedRectangle(cornerRadius: 20)
        //         .frame(width: 300, height: 500)
        //         .offset(offset)
        //         .scaleEffect(getScaleAmount())
        //         .rotationEffect(.degrees(getRotationAmount()))
        //         .animation(.bouncy, value: offset)
        //         .gesture(
        //             DragGesture()
        //                 .onChanged { value in
        //                     offset = value.translation
        //                 }
        //                 .onEnded { value in
        //                     offset = .zero
        //                 }
        //         )
        // }
        
        // MARK: Final example
        ZStack {
            signUpView
                .offset(y: startOffset + currentOffset + endOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            currentOffset = value.translation.height
                        }
                        .onEnded { value in
                            if currentOffset < -200 {
                                endOffset = -startOffset
                            } else if endOffset != 0 && currentOffset > 200 {
                                endOffset = 0
                            }
                            currentOffset = 0
                        }
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .animation(.smooth, value: currentOffset)
    }
    
    // MARK: - Subviews
    
    // MARK: Final example
    private var signUpView: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Image(systemName: "chevron.up")
                Text("Sign up")
                    .font(.headline.weight(.semibold))
            }
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("This is the description for our app. This is my favourite SwiftUI course and I recommend to all of my friends.")
                .multilineTextAlignment(.center)
            Text("CREATE AN ACCOUNT")
                .padding()
                .padding(.horizontal)
                .font(.headline)
                .foregroundStyle(.white)
                .background(Capsule())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 25).fill(.white))
        .ignoresSafeArea(edges: .bottom)
    }
    
    // MARK: - Methods
    
    // MARK: Tinder example
    // private func getScaleAmount() -> CGFloat {
    //     let max = UIScreen.main.bounds.width / 2
    //     let currentAmount = abs(offset.width)
    //     let percentage = currentAmount / max
    //     return 1.0 - min(percentage, 0.5) * 0.5
    // }
    //
    // private func getRotationAmount() -> Double {
    //     let max = UIScreen.main.bounds.width / 2
    //     let currentAmount = offset.width
    //     let percentage = Double(currentAmount / max)
    //     let maxAngle = 10.0
    //     return percentage * maxAngle
    // }
}

// MARK: - Preview

#Preview {
    DragGestureExample()
}
