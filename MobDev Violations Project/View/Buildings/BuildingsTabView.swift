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
    @ObservedObject private var buildingsVM = BuildingsSearchViewModel()
    
    
    var searchResults: [Building] {
        if searchText.isEmpty {
            return buildingsVM.listOfBuildings!
        } else {
            return (buildingsVM.listOfBuildings?.filter { $0.bin_id.contains(searchText.lowercased()) })!
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search buildings", text: $searchText)
                        .onChange(of: searchText) {

                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if !searchText.isEmpty {
                        Button("Cancel") {
                            searchText = ""
                        }
                        .padding(.trailing, 10)
                    }
                }
                
                if (buildingsVM.buildingsFetched){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination: BuildingDetailCardView()) {
                            Text("\(result.bin_id)")
                        }
                    }
                }
            }
            .navigationBarTitle("Buildings")
            .task{
                await buildingsVM.setAllBuildings()
            }
        }
    }
}

#Preview {
    BuildingsTabView()
}
