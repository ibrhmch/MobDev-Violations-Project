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
                    TextField("Filter Notice of Violations", text: $searchText)
                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            Task{
                                await novsVM.getSimilarNOVs(searchText)
                            }
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
                
                if ((novsVM.listOfNovs) != nil){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination:                                 NOVsDetailView(
                                bin_id: result.bin,
                                date: result.date ?? "",
                                status: result.status,
                                nov: result.nov))
                                {
                                    HStack{
                                        Text(result.nov)
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Circle()
                                            .foregroundColor(result.status ? .green : .purple)
                                            .frame(width: 10)
                                            .padding()
                                    }
                                    .background(.bar)
                                    .foregroundColor(.black)
                                    .cornerRadius(6.0)
                        }
                    }
                } else {
                    if searchText == "" {
                        Text("Search for a Notice of Violation")
                            .font(.subheadline)
                            .padding()
                    } else {
                        Text("Zero Notice of Violations Found")
                            .font(.headline)
                        Spacer()
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
