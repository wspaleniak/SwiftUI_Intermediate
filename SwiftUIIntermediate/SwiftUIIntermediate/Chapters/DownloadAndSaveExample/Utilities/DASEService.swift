//
//  DASEService.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 19/10/2024.
//

import Combine
import Foundation

final class DASEService {
    
    // MARK: - Properties
    
    static let shared = DASEService()
    
    @Published
    private(set) var images: [DASEImageModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    private init() {
        download()
    }
    
    // MARK: - Methods
    
    private func download() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [DASEImageModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] images in
                self?.images = images
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode
        else { throw URLError(.badServerResponse) }
        return output.data
    }
}
