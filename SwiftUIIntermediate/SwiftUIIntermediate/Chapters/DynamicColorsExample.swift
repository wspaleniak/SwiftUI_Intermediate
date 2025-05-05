//
//  DynamicColorsExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 20/10/2024.
//



// MARK: - NOTES

// MARK: 30 - Accessibility in Swift: Dynamic Colors
///
/// - przy pomocy wbudowanego w Xcode programu `Accessibility Inspector` możemy sprawdzić aplikację
/// - aby sprawdzić czy wybrany kontrast kolorów jest ok wchodzimy w `Accessibility Inspector > Window > Show Color Contrast Calculator`
/// - możemy tam podać kolor tekstu oraz kolor tła i dostaniemy informację czy będzie to dobre do czytania dla usera - pod uwagę są brane różne wielkości czcionek
/// - w ustawieniach telefonu user może sobie ustawić kilka rzeczy dotyczących kolorów w aplikacji i aplikacja powinna to respektować
/// - ale jeśli masz dobrze zrobione UI to nie powinno być potrzeby żeby używać wszystkich tych opcji podczas tworzenia aplikacji
/// - `Reduce Transparency` - zwiększa kontrast aby zredukować blury i przezroczystości z tła `\.accessibilityReduceTransparency` - true / false
/// - `Increase Contrast` - zwiększa kontrast pomiędzy elementami `foreground` a `background` `\.colorSchemeContrast` - standard / increased
/// - `Differentiate Without Color` - pozwala userowi ustawić kolory w appce na czarno-białe `\.accessibilityDifferentiateWithoutColor` - true / false
/// - `Smart Invert` - pozwala userowi odwrócić kolory w appce `\.accessibilityInvertColors` - true / false



// MARK: - CODE

import SwiftUI

struct DynamicColorsExample: View {
    
    // MARK: - Properties
    
    @Environment(\.accessibilityReduceTransparency)
    private var reduceTransparency
    
    @Environment(\.colorSchemeContrast)
    private var colorSchemeContrast
    
    @Environment(\.accessibilityDifferentiateWithoutColor)
    private var differentiateWithoutColor
    
    @Environment(\.accessibilityInvertColors)
    private var invertColors
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Button("Button 1") { }
                .foregroundStyle(colorSchemeContrast == .standard ? Color.primary : Color.white)
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            
            Button("Button 2") { }
                .foregroundStyle(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            
            Button("Button 3") { }
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)
                .tint(.green)
            
            Button("Button 4") { }
                .foregroundStyle(differentiateWithoutColor ? .white : .green)
                .buttonStyle(.borderedProminent)
                .tint(differentiateWithoutColor ? .black : .purple)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(.largeTitle)
        .background(reduceTransparency ? .black : .gray.opacity(0.5))
    }
}

// MARK: - Preview

#Preview {
    DynamicColorsExample()
}
