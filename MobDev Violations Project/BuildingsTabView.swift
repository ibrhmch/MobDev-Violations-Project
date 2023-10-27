//
//  BuildingsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

import SwiftUI

struct BuildingsTabView: View {
    @State private var searchText = ""
    @State private var recentSearches = [String]()
    @State private var searchResults = [String]()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search buildings", text: $searchText)
                        .onChange(of: searchText) { newValue in
                            // Generate random results when the search text changes
                            if !newValue.isEmpty {
                                searchResults = generateRandomResults()
                            } else {
                                searchResults.removeAll()
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if !searchText.isEmpty {
                        Button("Cancel") {
                            searchText = ""
                            searchResults.removeAll()
                        }
                        .padding(.trailing, 10)
                    }
                }

                // Recent Searches
                if !recentSearches.isEmpty {
                    List {
                        Section(header: Text("Recent Searches")) {
                            ForEach(recentSearches, id: \.self) { search in
                                Text(search)
                                    .onTapGesture {
                                        searchText = search
                                        searchResults = generateRandomResults()
                                    }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                }
                
                // Search Results
                List(searchResults, id: \.self) { result in
                    Text(result)
                }
            }
            .navigationBarTitle("Buildings")
        }
    }

    func deleteItems(at offsets: IndexSet) {
        recentSearches.remove(atOffsets: offsets)
    }

    func generateRandomResults() -> [String] {
        // Add the search text to recent searches if it's not already there
        if !recentSearches.contains(searchText) {
            recentSearches.append(searchText)
        }

        // Generate 2 or 3 random results
        let numberOfResults = Int.random(in: 2...3)
        return (0..<numberOfResults).map { _ in
            "Result \(Int.random(in: 1...100))"
        }
    }
}

#Preview {
    BuildingsTabView()
}
