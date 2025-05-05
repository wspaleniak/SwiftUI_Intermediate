//
//  FileManagerExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 13/10/2024.
//



// MARK: - NOTES

// MARK: 26 - Save data and images to FileManager in Xcode
///
/// - `FileManager` pozwala zapisać zdjęcie bezpośrednio bez zmiany na `Binary Data` w przeciwieństwie do `CoreData`
/// - jest świetny do zapisywania zdjęć, filmów, plików audio, plików JSON
/// - w backgroundzie podczas zapisywania plików lepiej używać `UIImage` zamiast `Image`
/// - najczęściej używane `directory` do zapisywania plików w `FileManager` na iOS:
/// - `FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)`
/// - `FileManager.default.urls(for: .cachesDirecory, in: .userDomainMask)`
/// - `FileManager.default.temporaryDirectory`
/// - przy pobieraniu `path` zapisanego pliku w wersji `String` używamy metody `path(percentEncoded:)`
/// - warto wtedy zwrócić uwagę na to że domyślnie argument `percentEncoded` jest ustawiony na `true` co może powodować błędy związane z dodaniem do `path` znaku `%` w miejscach białych znaków (np. spacji)
/// - możemy również tworzyć własne foldery za pomocą `FileManager.default.createDirectory(atPath:withIntermediateDirectories:)`
/// - zanim utworzymy folder należy sprawdzić czy już taki folder istnieje pod podaną ścieżką
/// - usuwanie folderu działa tak samo jak usuwanie pliku



// MARK: - CODE

import SwiftUI

final class FileManagerExampleManager {
    
    // MARK: - Properties
    
    static let shared = FileManagerExampleManager()
    
    private let folderName: String = "MyImages"
    
    // MARK: - Init
    
    init() {
        createFolderIfNeeded()
    }
    
    // MARK: - Methods
    
    func saveImage(_ image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getImagePath(for: name)
        else { return }
        try? data.write(to: path)
    }
    
    func getImage(for name: String) -> UIImage? {
        guard let path = getImagePath(for: name)?.path(percentEncoded: false),
              FileManager.default.fileExists(atPath: path)
        else { return nil }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(for name: String) {
        guard let path = getImagePath(for: name),
              FileManager.default.fileExists(atPath: path.path(percentEncoded: false))
        else { return }
        try? FileManager.default.removeItem(at: path)
    }
    
    func deleteFolder() {
        guard let path = getFolderPath(),
              FileManager.default.fileExists(atPath: path.path(percentEncoded: false))
        else { return }
        try? FileManager.default.removeItem(at: path)
    }
    
    private func createFolderIfNeeded() {
        guard let path = getFolderPath(),
              !FileManager.default.fileExists(atPath: path.path(percentEncoded: false))
        else { return }
        try? FileManager.default.createDirectory(
            at: path,
            withIntermediateDirectories: true
        )
    }
    
    private func getImagePath(for name: String) -> URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: folderName, directoryHint: .isDirectory)
            .appending(path: "\(name).jpg", directoryHint: .notDirectory)
    }
    
    private func getFolderPath() -> URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: folderName, directoryHint: .isDirectory)
    }
}



final class FileManagerExampleViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var image: UIImage?
    
    private let imageName: String = "steve-jobs"
    
    private let manager = FileManagerExampleManager.shared
    
    // MARK: - Init
    
    init() {
        getImage()
    }
    
    // MARK: - Methods
    
    func saveImage() {
        guard let image = UIImage(named: imageName) else {
            return
        }
        manager.saveImage(image, name: imageName)
    }
    
    func getImage() {
        image = manager.getImage(for: imageName)
    }
    
    func deleteImage() {
        manager.deleteImage(for: imageName)
        manager.deleteFolder()
    }
}



struct FileManagerExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = FileManagerExampleViewModel()
    
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
                    Text("Save to FileManager")
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
                    Text("Get from FileManager")
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
                    Text("Delete from FileManager")
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
            .navigationTitle("FileManager")
        }
    }
}

// MARK: - Preview

#Preview {
    FileManagerExample()
}
