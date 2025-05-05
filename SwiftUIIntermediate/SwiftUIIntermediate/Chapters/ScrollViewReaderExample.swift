//
//  ScrollViewReaderExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 22/09/2024.
//



// MARK: - NOTES

// MARK: 5 - ScrollViewReader to auto scroll in SwiftUI
///
/// - obiekt `ScrollViewReader` pozwala przescrollować z kodu `ScrollView` do wybranego miesjca
/// - obiekt `ScrollViewReader` dodajemy wewnątrz `ScrollView`
/// - używamy `proxy.scrollTo(id:anchor:)` do przeskrolowania do wybranego indeksu w liście
/// - argument `anchor` pozwala ustawić w którym miejscu na ekranie ma się znajdować wybrany indeks



// MARK: - CODE

import SwiftUI

struct ScrollViewReaderExample: View {
    
    // MARK: - Properties
    
    @FocusState private var isFocused: Bool
    @State private var text: String = ""
    @State private var indexToScroll: Int?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter index here", text: $text)
                    .focused($isFocused)
                    .padding()
                    .frame(height: 40)
                    .background(Capsule().stroke(.gray.opacity(0.5), lineWidth: 1))
                Button {
                    isFocused = false
                    indexToScroll = Int(text)
                } label: {
                    Text("Scroll")
                        .padding(.horizontal, 25)
                        .frame(height: 40)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(Capsule())
                }
            }
            .padding([.top, .horizontal])
            
            ScrollView {
                ScrollViewReader { proxy in
                    VStack {
                        ForEach(0..<50) {
                            Text("\($0)")
                                .id($0)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .font(.headline)
                                .background(Capsule().fill(.gray.opacity(0.2)))
                                .padding(.horizontal)
                        }
                    }
                    .onChange(of: indexToScroll) { _, value in
                        guard let value else {
                            return
                        }
                        withAnimation {
                            proxy.scrollTo(value, anchor: .top)
                            indexToScroll = nil
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ScrollViewReaderExample()
}
