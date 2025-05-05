//
//  DASEViewModel.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 19/10/2024.
//

import Combine
import Foundation

final class DASEViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var images: [DASEImageModel] = []
    
    private let service = DASEService.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init() {
        addObservation()
    }
    
    // MARK: - Methods
    
    private func addObservation() {
        service.$images
            .sink { [weak self] images in
                self?.images = images
            }
            .store(in: &cancellables)
    }
}
