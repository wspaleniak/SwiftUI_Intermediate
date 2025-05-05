//
//  SwiftUIIntermediateApp.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 30/06/2024.
//

import SwiftUI

@main
struct SwiftUIIntermediateApp: App {
    var body: some Scene {
        WindowGroup {
            FileManagerExample()
            
            // MultiThreadingExample()
            
            // CoreDataRelationshipsExample()
            
            // CoreDataMVVMExample()
            
            // CoreDataFetchRequestExample()
            //     .environment(\.managedObjectContext, CoreDataFetchRequestExampleManager.shared.container.viewContext)
        }
    }
}
