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
                    TextField("Search Notice of Violations", text: $searchText)
                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            Task{
                                await novsVM.getSimilarNOVs(searchText)
                            }
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
                
                if ((novsVM.listOfNovs) != nil){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination:                                 NOVsDetailView(
                                bin_id: result.bin,
                                date: result.date ?? "",
                                status: result.status,
                                nov: result.nov))
                                {
                            Text("\(result.nov)")
                        }
                    }
                }
            }
            .navigationBarTitle("Notice of Violations")
        }
    }

}

#Preview {
    NOVsTabView()
}
