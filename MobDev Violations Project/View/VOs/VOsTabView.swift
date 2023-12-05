//
//  VOsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct VOsTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var recentSearches = [String]()
    @ObservedObject private var violationsVM = ViolationsSearchViewModel()
    
    
    var searchResults: [ViolationOrder] {
        if searchText.isEmpty {
            return violationsVM.listOfViolations!
        } else {
            return (violationsVM.listOfViolations?.filter { $0.vo.contains(searchText.uppercased()) })!
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Filter Violation Orders", text: $searchText)                        
                            .onChange(of: searchText) {
                                recentSearches.append(searchText)
                                Task{
                                    await violationsVM.getSimilarViolations(searchText)
                            }
                        }
                    }.underlineTextField()

                    if !searchText.isEmpty {
                        Button("Cancel") {
                            searchText = ""
                        }
                        .foregroundColor(Color.primary)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 7)
                        .background(.gray)
                        .cornerRadius(7)
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                
                Spacer()
                
                if ((violationsVM.listOfViolations) != nil){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination: VOsDetailsView(
                                bin_id: result.bin,
                                date: result.date ?? "",
                                status: result.status,
                                vo: result.vo)) {
                                    VOsNOVsListCardView(id: result.vo, status: result.status)
                                }
                                .padding(.horizontal)
                                .background(colorScheme == .dark ? Color.black : Color(red: 240/255, green: 240/255, blue: 240/255))
                                .foregroundColor(Color.primary)
                                .cornerRadius(6.0)
                    }
                }  else {
                    if searchText == "" {
                        SearchForThisView(message: "Please search for a violation")
                    } else {
                        ZeroResultsFoundView(message: "Please search for a different violation")
                    }
                }
            }
            .navigationBarTitle("Search Violation Orders", displayMode: .inline)
        }
    }
}

#Preview {
    VOsTabView()
}
