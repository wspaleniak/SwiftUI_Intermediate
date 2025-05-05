//
//  DownloadJSONExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 09/10/2024.
//



// MARK: - NOTES

// MARK: 22 - Download JSON from API in Swift with URLSession and escaping closures
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

final class DownloadJSONExampleViewModel: ObservableObject {
    
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
    
    // MARK: - Init
    
    init() {
        getPosts()
    }
    
    // MARK: - Methods
    
    private func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        downloadData(from: url) { data in
            guard let posts = try? JSONDecoder().decode([PostModel].self, from: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.posts = posts
            }
        }
    }
    
    private func downloadData(
        from url: URL,
        completion: @escaping (Data) -> Void
    ) {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data,
                      error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300
                else { return }
                completion(data)
            }
            .resume()
        }
    }
}



struct DownloadJSONExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = DownloadJSONExampleViewModel()
    
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
    DownloadJSONExample()
}
