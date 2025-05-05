//
//  TimerAndOnReceiveExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 11/10/2024.
//



// MARK: - NOTES

// MARK: 24 - How to use Timer and onReceive in SwiftUI
///
/// - aby otrzymać obiekt `Publisher` z obiektu `Timer` używamy metody `Timer.publish(...)`
/// - wywołujemy również metodę `autoconnect()` jeśli chcemy aby `Publisher` zaczął publikować zmiany od razu po inicjalizacji widoku
/// - aby nasłuchiwać na publikacje z `Publishera` używamy modyfikatora `.onReceive(...)`



// MARK: - CODE

import SwiftUI

struct TimerAndOnReceiveExample: View {
    
    // MARK: - Properties
    
    @State
    private var timeRemaining: String = ""
    
    private let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    // MARK: - Body
    
    var body: some View {
        Text(timeRemaining)
            .lineLimit(1)
            .font(.largeTitle)
            .onReceive(timer) { value in
                updateTimeRemaining()
            }
    }
    
    // MARK: - Methods
    
    private func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents(
            [.hour, .minute, .second],
            from: Date(),
            to: futureDate
        )
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
}

// MARK: - Preview

#Preview {
    TimerAndOnReceiveExample()
}
