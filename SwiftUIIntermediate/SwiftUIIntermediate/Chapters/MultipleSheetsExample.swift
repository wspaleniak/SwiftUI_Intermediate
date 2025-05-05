//
//  MultipleSheetsExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 24/09/2024.
//



// MARK: - NOTES

// MARK: 7 - Multiple Sheets in a SwiftUI View
///
/// - `content` wewnątrz `.sheet` jest tworzony podczas budowania widoku
/// - dlatego jeśli przekazujemy do naszego `SheetView` zmienną która nie jest `@Binding` to widok który się pokaże podczas pierwszego wywołania `.sheet` będzie miał przypisaną w inicie zmienną z wartością początkową
/// - aby wszystko działało poprawnie mamy 3 rozwiązania:
/// - 1. użycie `@Binding`
/// - 2. użycie `Multiple sheets`
/// - 3. użycie `$item`
/// - najlepszym rozwiązaniem wydaje się opcja nr 3 czyli użycie `.sheet(item:content)`
/// - bardzo przydane zwłaszcza gdy mamy wiele różnych widoków do pokazania za pomocą `.sheet`



// MARK: - CODE

import SwiftUI

struct MultipleSheetsExample: View {
    
    // MARK: - Structs
    
    struct SheetModel: Identifiable {
        let id = UUID().uuidString
        let title: String
    }
    
    struct SheetView: View {
        // MARK: @Binding
        // @Binding private(set) var model: SheetModel
        
        // MARK: Multiple sheets
        // let model: SheetModel
        
        // MARK: $item
         let model: SheetModel
        
        var body: some View {
            ZStack {
                Text(model.title)
                    .font(.title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
        }
    }
    
    // MARK: - Properties
    
    // MARK: @Binding
    // @State private var selectedModel = SheetModel(title: "Starting title")
    // @State private var showSheet: Bool = false
    
    // MARK: Multiple sheets
    // @State private var showSheetFirst: Bool = false
    // @State private var showSheetSecond: Bool = false
    
    // MARK: $item
    @State private var selectedModel: SheetModel? = nil
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            Button("FIRST") {
                // MARK: @Binding
                // selectedModel = SheetModel(title: "First title")
                // showSheet.toggle()
                
                // MARK: Multiple sheets
                // showSheetFirst.toggle()
                
                // MARK: $item
                selectedModel = SheetModel(title: "First title")
            }
            
            Button("SECOND") {
                // MARK: @Binding
                // selectedModel = SheetModel(title: "Second title")
                // showSheet.toggle()
                
                // MARK: Multiple sheets
                // showSheetSecond.toggle()
                
                // MARK: $item
                selectedModel = SheetModel(title: "Second title")
            }
        }
        // MARK: @Binding
        // .sheet(isPresented: $showSheet) {
        //     SheetView(model: $selectedModel)
        // }
        
        // MARK: Multiple sheets
        // .sheet(isPresented: $showSheetFirst) {
        //     SheetView(model: .init(title: "First title"))
        // }
        // .sheet(isPresented: $showSheetSecond) {
        //     SheetView(model: .init(title: "Second title"))
        // }
        
        // MARK: $item
        .sheet(item: $selectedModel) {
            SheetView(model: $0)
        }
    }
}

// MARK: - Preview

#Preview {
    MultipleSheetsExample()
}
