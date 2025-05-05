//
//  DASEFileManager.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 20/10/2024.
//

import UIKit

final class DASEFileManager {
    
    // MARK: - Properties
    
    static let shared = DASEFileManager()
    
    private let folderName: String = "downloaded_images"
    
    // MARK: - Init
    
    private init() {
        createFolderIfNeeded()
    }
    
    // MARK: - Methods
    
    func add(_ image: UIImage, key: String) {
        guard let data = image.pngData(),
              let url = getImagePath(key: key)
        else { return }
        try? data.write(to: url)
    }
    
    func get(key: String) -> UIImage? {
        guard let imagePath = getImagePath(key: key),
              FileManager.default.fileExists(atPath: imagePath.path)
        else { return nil }
        return UIImage(contentsOfFile: imagePath.path)
    }
    
    private func createFolderIfNeeded() {
        guard let folderPath = getFolderPath(),
              !FileManager.default.fileExists(atPath: folderPath.path)
        else { return }
        try? FileManager.default.createDirectory(
            at: folderPath,
            withIntermediateDirectories: true
        )
    }
    
    private func getFolderPath() -> URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: folderName, directoryHint: .isDirectory)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folderPath = getFolderPath() else {
            return nil
        }
        return folderPath.appending(
            path: "\(key).png",
            directoryHint: .notDirectory
        )
    }
}
