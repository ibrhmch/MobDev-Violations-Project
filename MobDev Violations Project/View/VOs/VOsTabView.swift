//
//  VOsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct VOsTabView: View {
    @State private var searchText = ""
    @State private var recentSearches = [String]()
    @ObservedObject private var violationsVM = ViolationsSearchViewModel()
    
    
    var searchResults: [ViolationOrder] {
        if searchText.isEmpty {
            return violationsVM.listOfViolations!
        } else {
            return (violationsVM.listOfViolations?.filter { $0.vo.contains(searchText.lowercased()) })!
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search Violations", text: $searchText)
                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            print(recentSearches)
                            Task{
                                await violationsVM.getSimilarViolations(searchText)
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
                
                if ((violationsVM.listOfViolations) != nil){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination:                                 VOsDetailsView(
                                bin_id: result.bin_id,
                                date: result.date,
                                status: result.status,
                                vo: result.vo)) 
                                {
                            Text("\(result.vo)")
                        }
                    }
                }
            }
            .navigationBarTitle("Violations")
        }
    }
}

#Preview {
    VOsTabView()
}
