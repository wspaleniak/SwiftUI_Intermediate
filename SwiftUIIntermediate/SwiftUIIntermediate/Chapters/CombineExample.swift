//
//  CombineExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 12/10/2024.
//



// MARK: - NOTES

// MARK: 25 - Publishers and Subscribers in Combine with a SwiftUI project
///
/// - każdy `Publisher` musi być przechowywany w obiekcie typu `AnyCancellable`
/// - pojedynczy `Publisher` może przechować w obiekcie `var cancellable: AnyCancellable?`
/// - kilka obiektów typu `Publisher` możemy trzymać razem w jednym obiekcie `var cancellables: Set<AnyCancellable> = []`
/// - zmienne oznaczone `@Published` są publisherami
/// - do opóźnienia reakcji na nasłuchiwane wartości używamy `.debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)`
/// - aby nasłuchiwać na więcej niż jedną wartość jednocześnie używamy `.combineLatest(...)`



// MARK: - CODE

import Combine
import SwiftUI

final class CombineExampleViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var count: Int = .zero
    
    private var timerCancellable: AnyCancellable?
    
    @Published
    var textFieldText: String = ""
    
    @Published
    private(set) var textIsValid: Bool = false
    
    private var textFieldCancellable: AnyCancellable?
    
    @Published
    private(set) var showButton: Bool = false
    
    private var showButtonCancellable: AnyCancellable?
    
    // MARK: - Init
    
    init() {
        setupTimer()
        addTextFieldObservation()
        addShowButtonObservation()
    }
    
    // MARK: - Methods
    
    private func setupTimer() {
        timerCancellable = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                count += 1
                if count >= 10 { timerCancellable?.cancel() }
            }
    }
    
    private func addTextFieldObservation() {
        textFieldCancellable = $textFieldText
            .map { text in
                text.count > 3 ? true : false
            }
            .assign(to: \.textIsValid, on: self)
    }
    
    private func addShowButtonObservation() {
        showButtonCancellable = $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                self?.showButton = isValid && count >= 10
            }
    }
}



struct CombineExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = CombineExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        Text(viewModel.count.description)
            .font(.largeTitle)
        
        HStack {
            Text("is text valid:")
            Text(viewModel.textIsValid ? "YES" : "NO")
                .font(.headline)
                .foregroundStyle(viewModel.textIsValid ? .green : .red)
        }
        TextField("Something...", text: $viewModel.textFieldText)
            .padding()
            .font(.headline)
            .background(Capsule().fill(.gray.opacity(0.15)))
            .padding()
        
        Button {
            // Action...
        } label: {
            Text("Click me!")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(Capsule().fill(.blue))
                .padding(.horizontal)
                .opacity(viewModel.showButton ? 1.0 : 0.5)
        }
        .disabled(!viewModel.showButton)
    }
}

// MARK: - Preview

#Preview {
    CombineExample()
}
