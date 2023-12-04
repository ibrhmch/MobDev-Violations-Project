//
//  BuildingsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct BuildingsTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var recentSearches = [String]()
    @StateObject private var buildingsVM = BuildingsSearchViewModel()
    
    
    var searchResults: [Building] {
        if searchText.isEmpty {
            return buildingsVM.listOfBuildings ?? []
        } else {
            return buildingsVM.listOfBuildings?.filter { building in
                building.bin_id.lowercased().contains(searchText.lowercased()) ||
                building.address.lowercased().contains(searchText.lowercased())
            } ?? []
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }.underlineTextField()

                    if !searchText.isEmpty {
                        Button("Cancel") {
                            searchText = ""
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 7)
                        .background(.ultraThinMaterial)
                        .cornerRadius(7)
                        
                        Spacer()
                    }
                }
                .padding()
                .background(colorScheme == .dark ? .gray : .white)
                
                Spacer()
                
                if (buildingsVM.buildingsFetched){
                    if searchResults.count > 0 {
                        List(searchResults, id: \.self) { result in
                            NavigationLink(destination: BuildingDetailCardView(result.bin_id, result.address)) {
                                VStack{
                                    Text("\(result.bin_id)")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(result.address)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.subheadline)
                                }
                            }
                            .padding()
                            .background(colorScheme == .dark ? .gray : Color(red: 237/255, green: 237/255, blue: 237/255))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        }
                    } else {
                        ZeroResultsFoundView(message: "Please search for a different building")
                    }
                }
            }
            .navigationBarTitle("Viewing Buildings", displayMode: .inline)
            .task{
                await buildingsVM.setAllBuildings()
            }
        }
    }
}

#Preview {
    BuildingsTabView()
}
