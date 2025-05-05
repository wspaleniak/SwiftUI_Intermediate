//
//  SortFilterMapExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 30/09/2024.
//



// MARK: - NOTES

// MARK: 13 - Sort, Filter, and Map data arrays in Swift
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

final class SortFilterMapExampleVM: ObservableObject {
    
    // MARK: - Structs
    
    struct User: Identifiable {
        let id = UUID().uuidString
        let name: String
        let points: Int
        let isVerified: Bool
    }
    
    // MARK: - Properties
    
    @Published
    private(set) var users: [User] = []
    
    // SORT & FILTER
    @Published
    private(set) var filteredUsers: [User] = []
    
    // MAP
    @Published
    private(set) var mappedUsers: [String] = []
    
    // MARK: - Init
    
    init() {
        getUsers()
        // sortUsers()
        // filterUsers()
        mapUsers()
    }
    
    // MARK: - Methods
    
    private func getUsers() {
        users.append(contentsOf: [
            User(name: "Nick", points: 5, isVerified: true),
            User(name: "Chris", points: 0, isVerified: false),
            User(name: "Joe", points: 20, isVerified: true),
            User(name: "Emily", points: 50, isVerified: false),
            User(name: "Samantha", points: 45, isVerified: true),
            User(name: "Jason", points: 23, isVerified: false),
            User(name: "Sarah", points: 76, isVerified: true),
            User(name: "Lisa", points: 42, isVerified: false),
            User(name: "Steve", points: 1, isVerified: true),
            User(name: "Amanda", points: 100, isVerified: false),
        ])
    }
    
    private func sortUsers() {
        // LONGER
        // filteredUsers = users.sorted { user1, user2 -> Bool in
        //     user1.points > user2.points
        // }
        // SHORTER
        filteredUsers = users.sorted { $0.points > $1.points }
    }
    
    private func filterUsers() {
        // LONGER
        // filteredUsers = users.filter { user -> Bool in
        //     user.isVerified
        // }
        // SHORTER
        filteredUsers = users.filter { $0.isVerified }
    }
    
    private func mapUsers() {
        // LONGER
        // mappedUsers = users.map { user -> String in
        //     "\(user.name)-\(user.points)-\(user.isVerified)"
        // }
        // SHORTER
        mappedUsers = users.map {
            "\($0.name)-\($0.points)-\($0.isVerified)"
        }
    }
}



struct SortFilterMapExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = SortFilterMapExampleVM()
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                // SORT & FILTER
                // ForEach(viewModel.filteredUsers) { user in
                //     HStack {
                //         Text(user.name)
                //             .font(.headline)
                //         Text("\(user.points) pts")
                //         Spacer()
                //         if user.isVerified {
                //             Image(systemName: "checkmark.circle")
                //         }
                //     }
                //     .padding()
                //     .background(
                //         RoundedRectangle(cornerRadius: 10)
                //             .fill(.gray.opacity(0.15))
                //     )
                // }
                
                // MAP
                ForEach(viewModel.mappedUsers, id: \.self) { user in
                    Text(user)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.15))
                        )
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    SortFilterMapExample()
}
