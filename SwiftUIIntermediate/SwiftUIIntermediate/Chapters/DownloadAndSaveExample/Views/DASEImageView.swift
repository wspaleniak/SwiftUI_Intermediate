//
//  DASEImageView.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 19/10/2024.
//

import SwiftUI

struct DASEImageView: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel: DASEImageViewModel
    
    // MARK: - Init
    
    init(model: DASEImageModel) {
        _viewModel = StateObject(wrappedValue: .init(model: model))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DASEImageView(
        model: DASEImageModel(
            albumId: 1,
            id: 1,
            title: "Title",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "Thumbnail here"
        )
    )
}
