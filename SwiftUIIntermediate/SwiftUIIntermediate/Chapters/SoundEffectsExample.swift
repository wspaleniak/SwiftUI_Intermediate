//
//  SoundEffectsExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 28/09/2024.
//



// MARK: - NOTES

// MARK: 9 - How to add sound effects to Xcode project
///
/// - do odtwarzania dźwięków w appce potrzebujemy zaimportować framework `AVKit`
/// - dostarcza metod które pozwalają odtwarzać dźwięki i video w aplikacji
/// - aby odtwarzać dźwięki potrzebujemy obiektu typu `AVAudioPlayer`
/// - przekazujemy do niego `url` dźwięku i używamy metody `play()`



// MARK: - CODE

import AVKit
import SwiftUI

struct SoundEffectsExample: View {
    
    // MARK: - Classes
    
    final class SoundManager {
        enum SoundType: String {
            case tada
            case badum
        }
        static let shared = SoundManager()
        private var player: AVAudioPlayer?
        
        func playSound(_ sound: SoundType) {
            guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
                return
            }
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Play sound TADA") {
                SoundManager.shared.playSound(.tada)
            }
            Button("Play sound BADUM") {
                SoundManager.shared.playSound(.badum)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SoundEffectsExample()
}
