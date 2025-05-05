//
//  MultiThreadingExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 06/10/2024.
//



// MARK: - NOTES

// MARK: 17 - Multi-threading with background threads and queues in Xcode
///
/// - wszystkie zmiany związane z UI muszą być wykonywane na głównym wątku
/// - pozostałe rzeczy jak np. pobieranie danych z serwera powinny być wykonywane w tle
/// - argument `qos` oznacza `quality of service`
/// - do wyboru mamy kilka rodzajów globalnych wątków:
/// - `background`
/// - `default`
/// - `userInitiated`
/// - `utility`
/// - `userInteractive`
/// - `unspecified`
/// - możemy sprawdzić w każdej chwili czy dana czynność jest wykonywana na głównym wątku za pomocą `Thread.isMainThread`
/// - oraz sprawdzić dla danej czynności wątek na którym jest wykonywana za pomocą `Thread.current`



// MARK: - CODE

import SwiftUI

final class MultiThreadingExampleViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var data: [String] = []
    
    // MARK: - Methods
    
    func updateData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            print("1 - Current thread: \(Thread.current)")
            print("1 - Is main thread: \(Thread.isMainThread)")
            DispatchQueue.main.async {
                self.data.append(contentsOf: newData)
                print("2 - Current thread: \(Thread.current)")
                print("2 - Is main thread: \(Thread.isMainThread)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        (1...1000).map {
            let item = String($0)
            print(item)
            return item
        }
    }
}



struct MultiThreadingExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = MultiThreadingExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("LOAD DATA")
                    .font(.largeTitle.weight(.semibold))
                    .onTapGesture {
                        viewModel.updateData()
                    }
                ForEach(viewModel.data, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.indigo)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MultiThreadingExample()
}
