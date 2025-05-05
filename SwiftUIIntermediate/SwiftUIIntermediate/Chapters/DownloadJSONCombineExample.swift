//
//  DownloadJSONCombineExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 10/10/2024.
//



// MARK: - NOTES

// MARK: 23 - Download JSON from API in Swift with Combine
///
/// - aby móc używać funkcjonalności musimy zaimportować bibliotekę `Combine`
/// - główne elementy to frameworka to `Publisher` oraz `Subscriber`
/// - za każdym razem gdy `Publisher` będzie miał nową wartość, każdy `Subscriber` zostanie o tym powiadomiony



// MARK: - CODE

import Combine
import SwiftUI

final class DownloadJSONCombineExampleViewModel: ObservableObject {
    
    // MARK: - Structs
    
    struct PostModel: Identifiable, Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    
    // MARK: - Properties
    
    @Published
    private(set) var posts: [PostModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init() {
        getPosts()
    }
    
    // MARK: - Methods
    
    private func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            // OPCJA 1 - SINK WITH COMPLETION
            // .sink { result in
            //     switch result {
            //     case .finished:
            //         print("Success")
            //     case .failure(let error):
            //         print(error.localizedDescription)
            //     }
            // } receiveValue: { [weak self] posts in
            //     self?.posts = posts
            // }
            //
            // OPCJA 2 - SINK
            // .sink { [weak self] posts in
            //     self?.posts = posts
            // }
            //
            // OPCJA 3 - ASSIGN
            .replaceError(with: []) // gdy nie chcemy używać .sink z completion i sprawdzaniem error
            .assign(to: \.posts, on: self) // pozwala od razu przypisać dane do zmiennej bez użycia .sink
            .store(in: &cancellables)
    }
    
    private func handleOutput(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode
        else { throw URLError(.badServerResponse) }
        return output.data
    }
}



struct DownloadJSONCombineExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = DownloadJSONCombineExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .lineLimit(1)
                        .font(.headline)
                    Text(post.body)
                        .lineLimit(2)
                        .font(.subheadline)
                }
                .padding(8)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DownloadJSONCombineExample()
}
