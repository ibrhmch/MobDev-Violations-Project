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
    @ObservedObject private var buildingsVM = BuildingsViewModel()
    

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search buildings", text: $searchText)
                        .onChange(of: searchText) {
                            if !searchText.isEmpty {
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
                
                List(searchResults, id: \.self) { result in
                    Text(result)
                }
                
                if (buildingsVM.buildingsFetched){
                    List(buildingsVM.listOfBuildings!, id: \.self) { result in
                        Text("\(result.bin_id) - \(String(result.address.prefix(20)))")
                    }
                }
            }
            .navigationBarTitle("Buildings")
            .task{
                await buildingsVM.setAllBuildings()
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        recentSearches.remove(atOffsets: offsets)
    }

    func generateRandomResults() -> [String] {
        if !recentSearches.contains(searchText) {
            recentSearches.append(searchText)
        }

        let numberOfResults = Int.random(in: 2...3)
        return (0..<numberOfResults).map { _ in
            "Result \(Int.random(in: 1...100))"
        }
    }
}

#Preview {
    BuildingsTabView()
}
