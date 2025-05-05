//
//  DynamicTextExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 20/10/2024.
//



// MARK: - NOTES

// MARK: 29 - Accessibility in Swift: Dynamic Text
///
/// - każda appka którą się buduje powinna wspierać `Dynamic Type`
/// - czyli dopasowywać się wielkością tekstu do globalnych ustawień użytkownika
/// - modyfikator `.truncationMode` pozwala wybrać jak ma się zachować tekst który jest za długi
/// - np. może być widoczny tylko początek tekstu `.tail`, tylko środek `.middle` lub tylko koniec `.head`
/// - modyfikator `.lineLimit` pozwala ograniczyć ilość linii tekstu - domyślnie ma wartość `nil`
/// - modyfikator `.minimumScaleFactor` pozwala określić procentowo ile może się maksymalnie zmniejszyć wielkość tekstu gdy będzie się musiał dopasować do innych wymogów na widoku
/// - wartość `@Environment(\.sizeCategory)` pozwala sprawdzić jaki aktualnie rozmiar contentu jest ustawiony na telefonie
/// - możemy sobie rozszerzyć typ `ContentSizeCategory` i dodać zmienną przechowującą konkretny `minimumScaleFactor` dla konkretnych wielkości
/// - `\.sizeCategory` jest oznaczone jako `DEPRECATED` więc zamiast tego możemy używać `\.dynamicTypeSize`
/// - na podglądzie możemy kliknąć trzecią ikonkę od lewej i wybrać `Dynamic Type Variants` - pokaże nam to wszystkie dostępne wielkości contentu na wielu ekranach
/// - ikony domyślnie skalują się identycznie jak tekst w aplikacji
/// - ale żeby miała stałą wielkość możemy użyć modyfikatora `.font(.system(size: 50))`
/// - powyższego możemy użyć również dla tekstu i nie będzie wtedy dynamicznie się skalował



// MARK: - CODE

import SwiftUI

struct DynamicTextExample: View {
    
    // MARK: - Properties
    
    // DEPRECATED
    @Environment(\.sizeCategory)
    private var sizeCategory
    
    // NEW NEW NEW
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 20))
                            Text("Welcome to my app")
                        }
                        .font(.title)
                        
                        Text("This is some longer text that will wrap to the next line.")
                            .font(.subheadline)
                            .lineLimit(2)
                            // .minimumScaleFactor(0.5)
                            // .minimumScaleFactor(sizeCategory == .accessibilityExtraExtraExtraLarge ? 0.5 : 1.0)
                            // .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                            .minimumScaleFactor(dynamicTypeSize.customMinScaleFactor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.15))
                    // .frame(height: 100)
                    // .truncationMode(.middle)
                }
            }
            .navigationTitle("Dynamic text")
        }
    }
}

// MARK: - Extensions

extension ContentSizeCategory {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall: 1.0
        case .small: 1.0
        case .medium: 1.0
        case .large: 1.0
        case .extraLarge: 0.9
        case .extraExtraLarge: 0.9
        case .extraExtraExtraLarge: 0.8
        case .accessibilityMedium: 0.8
        case .accessibilityLarge: 0.7
        case .accessibilityExtraLarge: 0.6
        case .accessibilityExtraExtraLarge: 0.5
        case .accessibilityExtraExtraExtraLarge: 0.5
        @unknown default: 1.0
        }
    }
}

extension DynamicTypeSize {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .xSmall: 1.0
        case .small: 1.0
        case .medium: 1.0
        case .large: 1.0
        case .xLarge: 0.9
        case .xxLarge: 0.9
        case .xxxLarge: 0.8
        case .accessibility1: 0.8
        case .accessibility2: 0.7
        case .accessibility3: 0.6
        case .accessibility4: 0.5
        case .accessibility5: 0.5
        @unknown default: 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    DynamicTextExample()
}
