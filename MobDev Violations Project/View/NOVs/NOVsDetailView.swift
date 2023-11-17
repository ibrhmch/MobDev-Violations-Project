//
//  NOVsDetailView.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/16/23.
//

import SwiftUI

struct NOVsDetailView: View {
    var bin_id: String
    var date: String
    var status: Bool
    var nov: String
    
    var body: some View {
            NavigationView {
                VStack {
                    // Search bar placeholder
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()

                    GroupBox (label: Label("NOV Details", systemImage: "signpost.right")) {
                        Divider()
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("\(nov)")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            HStack {
                                Text("Issued On:")
                                Spacer()
                                Text("\(getDateFromString(date))")
                            }
                            HStack {
                                Text("BIN:")
                                Spacer()
                                Text("\(bin_id)")
                            }
                            HStack {
                                Text("Status:")
                                Spacer()
                                Text("\(status ? "Active" : "Dismissed")")
                            }
                        }
                        .padding()
                    }
                    .padding()
                    
                    Divider()
                    
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "doc.text.viewfinder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 24)
                            Text("View Receipt")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()

                    Spacer()
                }
                .navigationBarTitle("Viewing Notice of Violation", displayMode: .inline)
                .padding()
            }
        }
}

#Preview {
    NOVsDetailView(bin_id: "1091233", date: "Tue, 10 Oct 2023 14:14:25 GMT", status: true, nov: "014065990L")
}
