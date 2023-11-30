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
                    TextField("Search buildings", text: $searchText)
                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            print(recentSearches)
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
                
                Spacer()
                
                if (buildingsVM.buildingsFetched){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination: BuildingDetailCardView(result.bin_id, result.address)) {
                            VStack{
                                Text("\(result.bin_id)")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(result.address)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.bar)
                        .foregroundColor(.black)
                        .cornerRadius(10)
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
