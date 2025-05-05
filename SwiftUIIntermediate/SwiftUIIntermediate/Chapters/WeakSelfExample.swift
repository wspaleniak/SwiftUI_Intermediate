//
//  WeakSelfExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 07/10/2024.
//



// MARK: - NOTES

// MARK: 18 - How to use weak self in Swift
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

struct WeakSelfExample: View {
    
    // MARK: - Properties
    
    @AppStorage("count")
    private var count: Int?
    
    // MARK: - Init
    
    init() {
        count = 0
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(count ?? 0)")
                    .font(.largeTitle)
                NavigationLink("Go to second screen") {
                    WeakSelfExampleSecondScreen()
                }
            }
            .navigationTitle("First Screen")
        }
    }
}



final class WeakSelfExampleSecondScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var data: String? = nil
    
    // MARK: - Init
    
    init() {
        print("Initialize now")
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(count + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("Deinitialize now")
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(count - 1, forKey: "count")
    }
    
    // MARK: - Methods
    
    private func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.data = "New data"
        }
    }
}



struct WeakSelfExampleSecondScreen: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = WeakSelfExampleSecondScreenViewModel()
    
    // MARK: - Body
    
    var body: some View {
        Text(viewModel.data ?? "Data is empty...")
    }
}



// MARK: - Preview

#Preview {
    WeakSelfExample()
}
