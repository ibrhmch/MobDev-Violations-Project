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
            return (violationsVM.listOfViolations?.filter { $0.vo.contains(searchText.uppercased()) })!
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Filter Violations", text: $searchText)
                        .onChange(of: searchText) {
                            recentSearches.append(searchText)
                            Task{
                                await violationsVM.getSimilarViolations(searchText)
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
                
                if ((violationsVM.listOfViolations) != nil){
                    List(searchResults, id: \.self) { result in
                        NavigationLink(destination:                                 VOsDetailsView(
                                bin_id: result.bin,
                                date: result.date ?? "",
                                status: result.status,
                                vo: result.vo)) 
                                {
                                    HStack{
                                        Text(result.vo)
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
                }
            }
            .navigationBarTitle("Search Violation Orders", displayMode: .inline)
        }
    }
}

#Preview {
    VOsTabView()
}
