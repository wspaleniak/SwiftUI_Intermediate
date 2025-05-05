//
//  TypealiasExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 07/10/2024.
//



// MARK: - NOTES

// MARK: 19 - How to use Typealias in Swift
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

struct TypealiasExampleModel {
    let name: String
    let subtitle: String
}

struct TypealiasExample: View {
    
    typealias Model = TypealiasExampleModel
    
    // MARK: - Properties
    
    let model = Model(name: "Super Hero", subtitle: "Reunion")
    
    // MARK: - Body
    
    var body: some View {
        Text(model.name)
            .font(.title)
        Text(model.subtitle)
            .font(.subheadline)
    }
}

// MARK: - Preview

#Preview {
    TypealiasExample()
}
