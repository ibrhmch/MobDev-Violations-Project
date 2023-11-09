//
//  VOsDetailsView.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/9/23.
//

import SwiftUI

struct VOsDetailsView: View {
    var bin_id: String
    var date: String
    var status: Bool
    var vo: String
    
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

                    GroupBox (label: Label("Violation Order Details", systemImage: "signpost.left")) {
                        Divider()
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("\(vo)")
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
                .navigationBarTitle("Viewing Violation Order", displayMode: .inline)
                .padding()
            }
        }
}

func getDateFromString(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss 'GMT'"
    inputFormatter.timeZone = TimeZone(abbreviation: "GMT")

    guard let date = inputFormatter.date(from: dateString) else {
        return "2022-01-01"
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "yyyy-MM-dd" // or "dd MMM yyyy" for "10 Oct 2023"
    outputFormatter.timeZone = TimeZone(abbreviation: "GMT") // Set the timezone if needed
    
    return outputFormatter.string(from: date)
}

#Preview {
    VOsDetailsView(bin_id: "1091233", date: "Tue, 10 Oct 2023 14:14:25 GMT", status: true, vo: "LD123123")
}
