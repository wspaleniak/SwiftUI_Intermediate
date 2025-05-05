//
//  NSCacheExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 15/10/2024.
//



// MARK: - NOTES

// MARK: 27 - Save and cache images in a SwiftUI app
///
/// - stworzenie obiektu typu `NSCache` wymaga podania typów
/// - działa to podobnie jak słownik czyli pary klucz-wartość np: `NSCache<NSString, UIImage>`
/// - nie możemy użyć typu `String` ponieważ typ musi być klasą - z pomocą przychodzi `NSString`



// MARK: - CODE

import SwiftUI

final class NSCacheExampleManager {
    
    // MARK: - Properties
    
    static let shared = NSCacheExampleManager()
    
    private var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()
    
    // MARK: - Methods
    
    func save(_ image: UIImage, name: String) {
        cache.setObject(image, forKey: name as NSString)
    }
    
    func get(for name: String) -> UIImage? {
        cache.object(forKey: name as NSString)
    }
    
    func delete(for name: String) {
        cache.removeObject(forKey: name as NSString)
    }
}



final class NSCacheExampleViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var image: UIImage?
    
    private let imageName: String = "steve-jobs"
    
    private let manager = NSCacheExampleManager.shared
    
    // MARK: - Init
    
    init() {
        getImage()
    }
    
    // MARK: - Methods
    
    func saveImage() {
        guard let image = UIImage(named: imageName) else {
            return
        }
        manager.save(image, name: imageName)
    }
    
    func getImage() {
        image = manager.get(for: imageName)
    }
    
    func deleteImage() {
        manager.delete(for: imageName)
    }
}



struct NSCacheExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = NSCacheExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .padding()
                }
                
                Button {
                    viewModel.saveImage()
                } label: {
                    Text("Save to Cache")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                
                Button {
                    viewModel.getImage()
                } label: {
                    Text("Get from Cache")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                
                Button {
                    viewModel.deleteImage()
                } label: {
                    Text("Delete from Cache")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(.red)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("NSCache")
        }
    }
}

// MARK: - Preview

#Preview {
    NSCacheExample()
}
