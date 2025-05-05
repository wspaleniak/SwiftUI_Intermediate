//
//  HapticsVibrationsExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 28/09/2024.
//



// MARK: - NOTES

// MARK: 10 - How to add haptics and vibrations to Xcode project
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

struct HapticsVibrationsExample: View {
    
    // MARK: - Classes
    
    final class HapticManager {
        static let shared = HapticManager()
        
        func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(type)
        }
        func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            Button("success") { HapticManager.shared.notification(.success) }
            Button("warning") { HapticManager.shared.notification(.warning) }
            Button("error") { HapticManager.shared.notification(.error) }
            Divider()
            Button("soft") { HapticManager.shared.impact(.soft) }
            Button("light") { HapticManager.shared.impact(.light) }
            Button("medium") { HapticManager.shared.impact(.medium) }
            Button("rigid") { HapticManager.shared.impact(.rigid) }
            Button("heavy") { HapticManager.shared.impact(.heavy) }
        }
    }
}

// MARK: - Preview

#Preview {
    HapticsVibrationsExample()
}
