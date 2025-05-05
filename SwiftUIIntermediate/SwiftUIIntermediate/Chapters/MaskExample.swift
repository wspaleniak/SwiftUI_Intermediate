//
//  MaskExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 24/09/2024.
//



// MARK: - NOTES

// MARK: 8 - How to use Mask in SwiftUI to create a 5-star rating button
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

struct MaskExample: View {
    
    // MARK: - Properties

    @State
    private var rating: Int = .zero
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            starsView
                .overlay {
                    starsOverlayView
                        .mask(starsView)
                }
        }
        .animation(.smooth, value: rating)
    }
    
    // MARK: - Subviews
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
    
    private var starsOverlayView: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.pink, .purple, .indigo, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: CGFloat(rating) / 5 * proxy.size.width)
                    .allowsHitTesting(false)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MaskExample()
}
