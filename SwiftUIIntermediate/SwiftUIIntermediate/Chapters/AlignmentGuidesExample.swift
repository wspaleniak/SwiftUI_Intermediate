//
//  AlignmentGuidesExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 25/10/2024.
//



// MARK: - NOTES

// MARK: 32 - How to use Alignment Guides in SwiftUI
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

struct AlignmentGuidesExample: View {
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Hello, World!")
                .background(.blue)
                .alignmentGuide(.leading) { dimensions in
                    dimensions.width
                }
            Text("This is another text!")
                .background(.red)
        }
        .background(.yellow)
        
        VStack(alignment: .leading, spacing: 20) {
            row("First", showIcon: false)
            row("Second", showIcon: true)
            row("Third", showIcon: true)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .shadow(radius: 10)
        .padding(40)
    }
    
    // MARK: Subviews
    
    private func row(_ title: String, showIcon: Bool) -> some View {
        HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            Text(title)
            Spacer()
        }
        .alignmentGuide(.leading) { dimensions in
            showIcon ? 40 : 0
        }
    }
}

// MARK: - Preview

#Preview {
    AlignmentGuidesExample()
}
