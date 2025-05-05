//
//  EscapingClosuresExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 07/10/2024.
//



// MARK: - NOTES

// MARK: 20 - How to use escaping closures in Swift
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

final class EscapingClosuresExampleViewModel: ObservableObject {
    
    typealias Completion = (String) -> Void
    
    // MARK: - Properties
    
    @Published
    private(set) var text: String = "Hello!"
    
    // MARK: - Methods
    
    func getData() {
        downloadData { [weak self] newData in
            self?.text = newData
        }
    }
    
    private func downloadData(_ completion: @escaping Completion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion("Guten tag!")
        }
    }
}



struct EscapingClosuresExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = EscapingClosuresExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle.weight(.semibold))
            .foregroundStyle(.blue)
            .onTapGesture {
                viewModel.getData()
            }
    }
}

// MARK: - Preview

#Preview {
    EscapingClosuresExample()
}
