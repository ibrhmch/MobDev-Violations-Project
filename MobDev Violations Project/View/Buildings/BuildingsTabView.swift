//
//  BuildingsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct BuildingsTabView: View {
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
                    TextField("Filter Buildings", text: $searchText)
                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            print(recentSearches)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    if !searchText.isEmpty {
                        Button("Cancel") {
                            searchText = ""
                        }
                        .padding(.trailing, 10)
                    }
                }
                
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
                            .background(.bar)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        }
                    } else {
                        Text("Zero Buildings Found")
                            .font(.headline)
                        Spacer()
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
