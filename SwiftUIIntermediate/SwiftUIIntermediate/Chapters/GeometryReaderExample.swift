//
//  GeometryReaderExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 24/09/2024.
//



// MARK: - NOTES

// MARK: 6 - GeometryReader in SwiftUI to get a view's size and location
///
/// - `GeometryReader` używamy żeby móc odczytać rozmiar i lokalizację danego obiektu który się znajduje wewnątrz
/// - do odczytania rozmiaru używamy `proxy.size`
/// - do odczytania lokalizacji używamy np. `proxy.frame(in: .global).midX`
/// - możemy użyć predefiniowanych wartości `.global` lub `.local`
/// - albo możemy oznaczyć dany obiekt za pomocą `.coordinateSpace("scrollView")`
/// - odnosimy się wtedy do jego obszaru przy pomocy `proxy.frame(in: "scrollView").midX`



// MARK: - CODE

import SwiftUI

struct GeometryReaderExample: View {
    
    // MARK: - Body
    
    var body: some View {
        // MARK: First example
        // GeometryReader { proxy in
        //     HStack(spacing: .zero) {
        //         Rectangle()
        //             .fill(.red)
        //             .frame(width: proxy.size.width * 0.7)
        //         Rectangle()
        //             .fill(.blue)
        //     }
        //     .ignoresSafeArea()
        // }
        
        // MARK: Second example
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<20) { _ in
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                .degrees(getPercentage(proxy) * 10),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 200)
                }
            }
            .padding(.horizontal, 30)
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Methods
    
    // MARK: Second example
    private func getPercentage(_ proxy: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = proxy.frame(in: .global).midX
        return 1.0 - (currentX / maxDistance)
    }
}

// MARK: - Preview

#Preview {
    GeometryReaderExample()
}
