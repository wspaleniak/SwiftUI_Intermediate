//
//  CoreDataMVVMExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 03/10/2024.
//



// MARK: - NOTES

// MARK: 15 - How to use Core Data with MVVM Architecture in SwiftUI
///
/// - ONLY CODE



// MARK: - CODE

import CoreData
import SwiftUI

final class CoreDataMVVMExampleVM: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var fruits: [FruitEntity] = []
    
    @Published
    var text: String = ""
    
    private let container: NSPersistentContainer
    
    // MARK: - Init
    
    init() {
        container = NSPersistentContainer(name: "ExampleModel")
        container.loadPersistentStores { description, error in
            if let error { print(error.localizedDescription) }
        }
        fetchFruits()
    }
    
    // MARK: - Methods
    
    func addFruit() {
        guard !text.isEmpty else {
            return
        }
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        save()
        text = ""
    }
    
    func updateFruit(_ fruit: FruitEntity, with name: String) {
        fruit.name = name
        save()
    }
    
    func deleteFruit(_ indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        container.viewContext.delete(fruits[index])
        save()
    }
    
    private func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            fruits = try container.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func save() {
        try? container.viewContext.save()
        fetchFruits()
    }
}



struct CoreDataMVVMExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = CoreDataMVVMExampleVM()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Add new fruit...", text: $viewModel.text)
                        .padding()
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.15))
                        )
                    Button {
                        viewModel.addFruit()
                    } label: {
                        Label("Add", systemImage: "plus")
                            .padding()
                            .frame(height: 50)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                            )
                    }
                }
                .padding()
                
                List {
                    ForEach(viewModel.fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                viewModel.updateFruit(fruit, with: "UPDATED")
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruit)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

// MARK: - Preview

#Preview {
    CoreDataMVVMExample()
}
