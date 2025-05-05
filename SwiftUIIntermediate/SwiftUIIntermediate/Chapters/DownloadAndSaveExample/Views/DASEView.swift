//
//  DASEView.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 18/10/2024.
//



// MARK: - NOTES

// MARK: 28 - Download and save images using FileManager and NSCache
///
/// - w tej mini appce mamy zaimplementowane dwa rodzaje zapisywania pobranych zdjęć
/// - za pomocą `FileManager` - dane te są przechowywane w pamięci stałej telefonu i muszą zostać wyczyszczone manualnie
/// - po zamknięciu aplikacji `FileManager` nadal przechowuje pobrane dane
/// - za pomocą `NSCache` - dane te są przechowywane w pamięci podręcznej i czyszczone gdy przekraczają `totalCostLimit`
/// - żeby nie zamulić działanie telefonu poprzez wykorzystanie zbyt dużej ilości pamięci podręcznej powinno się używać ograniczenia `totalCostLimit`
/// - po zamknięciu aplikacji `NSCache` jest czyszczone a dane usuwane



// MARK: - CODE

import SwiftUI

struct DASEView: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = DASEViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.images) { image in
                    DASERowView(image: image)
                }
            }
            .navigationTitle("Images")
        }
    }
}

// MARK: - Preview

#Preview {
    DASEView()
}
