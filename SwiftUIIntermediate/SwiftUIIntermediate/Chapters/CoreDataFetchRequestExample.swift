//
//  CoreDataFetchRequestExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 30/09/2024.
//



// MARK: - NOTES

// MARK: 14 - How to use Core Data with @FetchRequest in SwiftUI
///
/// - aby zapisać np. zdjęcie w `Core Data` musimy użyć typu `Binary Data`
/// - aby utworzyć nowy model klikamy `Cmd+N` i wybieramy `Data Model`
/// - nowy obiekt w modelu tworzymy klikając `Add Entity`
/// - pola obiektu tworzymy w zakładce `Attributes` - wszystkie pola z automatu są zaznaczone jako `Optional`
/// - aby nadpisać aktualny model nowym modelem klikamy w aktualny model i wybieramy `Editor > Add Model Version...`
/// - następnie musimy ustawić nowy model jako aktualnie używany przez aplikację - w tym celu klikamy `Cmd+Option+0` i w sekcji `Model Version` wybieramy najnowszą wersję modelu
/// - aby używać `Core Data` należy zaimportować bibliotekę `import CoreData`
/// - zapisywanie, edytowanie i usuwanie plików wymaga odwołania się do obiektu typu `NSManagedObjectContext` który z kolei znajduje się w kontenerze typu `NSPersistentContainer` - na kontenerze wywołujemy metodę `loadPersistentStores`
/// - kontener tworzymy jeden dla całego modelu danych (może mieć wiele `Entity`)
/// - w `SwiftUI` view context możemy przekazać do widoku za pomocą modyfikatora `.environment(\.managedObjectContext, ...)`
/// - w widoku odwołujemy się wtedy do niego za pomocą `@Environment(\.managedObjectContext)`
/// - do obiektów zapisanych w bazie o wybranym typie `Entity` mamy dostęp za pomocą `@FetchRequest(...)` gdzie jako argumenty możemy podać m.in. rodzaj sortowania elementów - elementy są typu `FetchedResults<FruitEntity>` i używamy ich jak tablicy obiektów `FruitEntity`



// MARK: - CODE

import CoreData
import SwiftUI

final class CoreDataFetchRequestExampleManager {
    
    // MARK: - Properties
    
    static let shared = CoreDataFetchRequestExampleManager()
    let container: NSPersistentContainer
    
    // MARK: - Init
    
    init() {
        container = NSPersistentContainer(name: "ExampleModel")
        container.loadPersistentStores { storeDescription, error in
            if let error { print(error.localizedDescription) }
        }
    }
}



struct CoreDataFetchRequestExample: View {
    
    // MARK: - Properties
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default
    )
    private var fruits: FetchedResults<FruitEntity>
    
    @State
    private var text: String = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Add new fruit...", text: $text)
                        .padding()
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.15))
                        )
                    Button {
                        addItem()
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
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                updateItem(fruit)
                            }
                    }
                    .onDelete(perform: deleteItem)
                }
            }
            .navigationTitle("Fruits")
        }
    }
    
    // MARK: - Methods
    
    private func addItem() {
        guard !text.isEmpty else {
            return
        }
        let fruit = FruitEntity(context: viewContext)
        fruit.name = text
        try? viewContext.save()
        text = ""
    }
    
    private func updateItem(_ fruit: FruitEntity) {
        fruit.name = "NEW! \(fruit.name ?? "")"
        try? viewContext.save()
    }
    
    private func deleteItem(_ indexSet: IndexSet) {
        guard let indexSet = indexSet.first else {
            return
        }
        viewContext.delete(fruits[indexSet])
        try? viewContext.save()
    }
}

// MARK: - Preview

#Preview {
    CoreDataFetchRequestExample()
}
