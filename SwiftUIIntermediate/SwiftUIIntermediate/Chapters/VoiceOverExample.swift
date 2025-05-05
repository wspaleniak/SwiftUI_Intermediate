//
//  VoiceOverExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 20/10/2024.
//



// MARK: - NOTES

// MARK: 31 - Accessibility in Swift: Voice Over
///
/// - jest to funkcja wydawania komend dla telefonu - głównie dla osób które nie mogą zobaczyć ekranu
/// - natywne elementy UI są do tego przystosowane, dlatego w miarę mozliwości lepiej ich używać niż pisać własne
/// - natomiast żeby połączyć je w jeden obiekt można użyć `.accessibilityElement(children: .combine)`
/// - żeby określić czym ten obiekt jest możemy użyć np. `.accessibilityAddTraits(.isButton)`
/// - możemy również ustawić własną podpowiedź która będzie odczytana `.accessibilityHint("...")`
/// - aby określi jaka akcja ma się wykonać używamy `.accessibilityAction { ... }`
/// - aby usunąć info o tym czym ten obiekt jest używamy np. `.accessibilityRemoveTraits(.isButton)`
/// - aby dodać nazwę obiektu używamy `.accessibilityLabel("...")`



// MARK: - CODE

import SwiftUI

struct VoiceOverExample: View {
    
    // MARK: - Properties
    
    @State
    private var isOn: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Volume", isOn: $isOn)
                    
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text(isOn ? "ON" : "OFF")
                            .accessibilityHidden(true)
                    }
                    .contentShape(.rect)
                    .onTapGesture { isOn.toggle() }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(isOn ? "is on" : "is off")
                    .accessibilityHint("Double tap to toggle setting.")
                    .accessibilityAction { isOn.toggle() }
                } header: {
                    Text("PREFERENCES")
                }
                
                Section {
                    Button("Favourites") { }
                        .accessibilityRemoveTraits(.isButton)
                    
                    Button { } label: { Image(systemName: "heart.fill") }
                        .accessibilityLabel("Favourites")
                    
                    Text("Favourites")
                        .onTapGesture { }
                        .accessibilityAddTraits(.isButton)
                } header: {
                    Text("APPLICATION")
                }
                
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .accessibilityAddTraits(.isHeader)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) { index in
                                VStack {
                                    Image("steve-jobs")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    Text("Item \(index)")
                                }
                                .onTapGesture { }
                                .accessibilityElement(children: .combine)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Item \(index)")
                                .accessibilityHint("Double tap to open.")
                                .accessibilityAction { }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// MARK: - Preview

#Preview {
    VoiceOverExample()
}
