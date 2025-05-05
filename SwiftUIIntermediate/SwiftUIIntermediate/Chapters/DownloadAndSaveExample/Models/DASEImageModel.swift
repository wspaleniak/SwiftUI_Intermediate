//
//  DASEImageModel.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 19/10/2024.
//

import Foundation

struct DASEImageModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
