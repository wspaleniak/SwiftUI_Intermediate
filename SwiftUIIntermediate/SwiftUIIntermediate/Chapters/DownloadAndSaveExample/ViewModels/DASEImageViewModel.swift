//
//  DASEImageViewModel.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 19/10/2024.
//

import Combine
import UIKit

final class DASEImageViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let model: DASEImageModel
    
    @Published
    private(set) var image: UIImage?
    
    @Published
    private(set) var isLoading: Bool = false
    
    private let fileManager = DASEFileManager.shared
    
    private let cacheManager = DASECacheManager.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(model: DASEImageModel) {
        self.model = model
        getImage()
    }
    
    // MARK: - Methods
    
    private func getImage() {
        // FILE MANAGER
        // if let savedImage = fileManager.get(key: "\(model.id)")
        // CACHE MANAGER
        if let savedImage = cacheManager.get(key: "\(model.id)") {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        isLoading = true
        guard let url = URL(string: model.url) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] downloadedImage in
                guard let self,
                      let downloadedImage
                else { return }
                image = downloadedImage
                // FILE MANAGER
                // fileManager.add(downloadedImage, key: "\(model.id)")
                // CACHE MANAGER
                cacheManager.add(downloadedImage, key: "\(model.id)")
            }
            .store(in: &cancellables)
    }
}
