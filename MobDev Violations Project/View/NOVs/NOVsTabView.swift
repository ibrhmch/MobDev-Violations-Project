//
//  NOVsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct NOVsTabView: View {
    @State private var searchText = ""
    @State private var recentSearches = [String]()
    @ObservedObject private var novsVM = NOVSearchViewModel()
    
    
    var searchResults: [NoticeOfViolations] {
        if searchText.isEmpty {
            return novsVM.listOfNovs!
        } else {
            return (novsVM.listOfNovs?.filter { $0.nov.contains(searchText.uppercased()) })!
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Filter Notice of Violations", text: $searchText)                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            Task{
                                await novsVM.getSimilarNOVs(searchText)
                            }
                        }
                    }
                    .underlineTextField()

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
                .background(.white)
                
                Spacer()
                
                if ((novsVM.listOfNovs) != nil){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination: NOVsDetailView(
                                bin_id: result.bin,
                                date: result.date ?? "",
                                status: result.status,
                                nov: result.nov)){
                                    VOsNOVsListCardView(id: result.nov, status: result.status)
                                }
                                .padding(.horizontal)
                                .background(.bar)
                                .foregroundColor(.black)
                                .cornerRadius(6.0)
                    }
                } else {
                    if searchText == "" {
                        SearchForThisView(message: "Please search for a notice of violation")
                    } else {
                        ZeroResultsFoundView(message: "Please search for a different notice of violation")
                    }
                }
            }
            .navigationBarTitle("Search Notice of Violations", displayMode: .inline)
        }
    }
}

#Preview {
    NOVsTabView()
}
