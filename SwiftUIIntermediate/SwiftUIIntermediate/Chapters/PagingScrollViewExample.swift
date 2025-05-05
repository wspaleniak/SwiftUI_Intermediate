//
//  PagingScrollViewExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 26/10/2024.
//



// MARK: - NOTES

// MARK: 34 - Paging ScrollView in SwiftUI for iOS 17
///
/// - modyfikator `.scrollBounceBehavior()` pozwala włączyć/wyłączyć efekt odbicia przy przewijaniu
/// - do wyboru mamy 3 opcje `.always`, `.automatic`, `.basedOnSize`
/// - modyfikatory `scrollTargetLayout()` oraz `.scrollTargetBehavior(.viewAligned)` pozwalają ustawić przewijanie tak aby dociągało elementy w ten sposób aby ten na górze był zawsze widoczny w całości - muszą być użyte razem, jeden po drugim
/// - na cellkę która jest w `ScrollView` możemy dodać modyfikator `.containerRelativeFrame(.vertical, alignment: .center)` który w połączeniu z dodaniem na `ScrollView` modyfikatora `.scrollTargetBehavior(.paging)` sprawi że na ekranie będzie widoczna jedna cellka i będzie można ją przwijać jak strony które będą się same dociągać
/// - za to w jaki sposób będą pojawiać się cellki w `ScrollView` odpowiada `.scrollTransition(...)`
/// - jest to domknięcie które ma 2 argumenty `content` typu `EmptyVisualEffect` oraz `phase` typu `ScrollTransitionPhase`



// MARK: - CODE

import SwiftUI

struct PagingScrollViewExample: View {
    
    // MARK: - Properties
    
    @State
    private var scrollPosition: Int?
    
    // MARK: - Body
    
    var body: some View {
        // MARK: FIRST EXAMPLE - vertical
        // ScrollView {
        //     VStack(spacing: .zero) {
        //         ForEach(0..<20) { index in
        //             Rectangle()
        //                 .fill(.indigo)
        //                 .frame(maxWidth: .infinity)
        //                 .overlay {
        //                     Text("\(index)")
        //                         .foregroundStyle(.white)
        //                 }
        //                 .containerRelativeFrame(.vertical, alignment: .center)
        //         }
        //     }
        // }
        // .ignoresSafeArea()
        // .scrollTargetLayout()
        // .scrollTargetBehavior(.paging)
        // .scrollBounceBehavior(.basedOnSize)
        
        // MARK: SECOND EXAMPLE - horizontal
        VStack {
            Button("SCROLL TO") {
                scrollPosition = (0..<20).randomElement()
            }
            ScrollView(.horizontal) {
                HStack(spacing: .zero) {
                    ForEach(0..<20) { index in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.indigo)
                            .frame(width: 300, height: 300)
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal)
                            .scrollTransition(.interactive.threshold(.visible(0.9))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                            }
                            .id(index)
                    }
                }
                .padding(.vertical, 100)
            }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .animation(.smooth, value: scrollPosition)
        }
    }
}

// MARK: - Preview

#Preview {
    PagingScrollViewExample()
}
