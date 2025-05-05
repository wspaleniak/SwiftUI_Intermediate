//
//  HashableExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 29/09/2024.
//



// MARK: - NOTES

// MARK: 12 - What is Hashable protocol in SwiftUI
///
/// - w `SwiftUI` jest dużo komponentów które wymagają aby model był zgodny z protokołem `Hashable`
/// - taki model posiada wtedy unikalny `hash` który jest podobny do `id` z protokołu `Identifiable`
/// - `hash` jest używany w wielu językach programowania, nie tylko w `Swift`
/// - dla przykładu typ `String` jest zgodny z `Hashable` i może my się odwołać do jego `hashValue`
/// - po przeładowaniu widoku wartość `hashValue` obiektu się zmienia
/// - zamiast zgodności z protokołem `Hashable` możemy użyć zgodności z `Identifiable` ale wtedy model musi posiadać pole `id` - nie zawsze chcemy to dodawać
/// - podczas zgodności z `Hashable` możemy dodać metodę `hash()` która tworzy `hash` dla modelu na bazie podanych pól - w wywołaniu `hasher.combine()` możemy podać wiele pól modelu dzięki czemu `hash` będzie bardziej unikalny
/// - zgodności z `Equatable` używamy wtedy gdy mamy do czynienia z bardziej złożonymi typami które nie mogą być zgodne z `Hashable` - np. enumy z wartością powiązaną - wtedy potrzebna jest dodatkowa logika do ich porównywania



// MARK: - CODE

import SwiftUI

struct HashableExample: View {
    
    // MARK: - Structs
    
    // IDENTIFIABLE
    // struct Fruit: Identifiable {
    //     let id = UUID().uuidString
    //     let name: String
    // }
    
    // HASHABLE
    struct Fruit: Hashable {
        let name: String
        let subtitle: String
        func hash(into hasher: inout Hasher) {
            hasher.combine(name + subtitle)
        }
    }
    
    // MARK: - Properties
    
    // STRING
    // private let fruits: [String] = [
    //     "banana",
    //     "orange",
    //     "cherry",
    //     "lemon"
    // ]
    
    // IDENTIFIABLE
    // private let fruits: [Fruit] = [
    //     Fruit(name: "banana"),
    //     Fruit(name: "orange"),
    //     Fruit(name: "cherry"),
    //     Fruit(name: "lemon")
    // ]
    
    // HASHABLE
    private let fruits: [Fruit] = [
        Fruit(name: "banana", subtitle: "111"),
        Fruit(name: "orange", subtitle: "222"),
        Fruit(name: "cherry", subtitle: "333"),
        Fruit(name: "lemon", subtitle: "444")
    ]
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                // STRING
                // ForEach(fruits, id: \.self) {
                //     Text($0.hashValue.description)
                // }
                
                // IDENTIFIABLE
                // ForEach(fruits) {
                //     Text($0.id)
                // }
                
                // HASHABLE
                ForEach(fruits, id: \.self) {
                    Text($0.hashValue.description)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HashableExample()
}
