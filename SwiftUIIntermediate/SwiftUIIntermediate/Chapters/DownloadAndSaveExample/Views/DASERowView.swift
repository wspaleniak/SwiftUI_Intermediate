//
//  DASERowView.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 19/10/2024.
//

import SwiftUI

struct DASERowView: View {
    
    // MARK: - Properties
    
    let image: DASEImageModel
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            DASEImageView(model: image)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(image.title)
                    .font(.headline)
                Text(image.url)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Preview

#Preview {
    DASERowView(
        image: DASEImageModel(
            albumId: 1,
            id: 1,
            title: "Title",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "Thumbnail here"
        )
    )
    .background(.yellow)
}
