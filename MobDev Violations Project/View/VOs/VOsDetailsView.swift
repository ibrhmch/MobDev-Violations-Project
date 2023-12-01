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

                    GroupBox () {
                        HStack{
                            Label("\(vo)", systemImage: "signpost.left")
                                .font(.headline)
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 5) {
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
                            Rectangle()
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(status ? .green : .purple)
                                .frame(height: 7)
                                .padding(.top)
                        }
                        .padding()
                        .font(.subheadline)
                    }
                    .padding()
                    
                    Divider()
                    
                    // View Receipt BUtton
                    Button(action: {
                        if let url = URL(string: "https://fires.fdnycloud.org/CitizenAccess/Cap/CapDetail.aspx?Module=BFP&TabName=BFP&capID1=07F05&capID2=00000&capID3=055UP&agencyCode=FDNY&IsToShowInspection=") {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }) {
                        HStack {
                            Label("Open Receipt", systemImage: "safari.fill")
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    .padding()

                    Spacer()
                }
                .navigationBarTitle("Viewing Violation Order", displayMode: .inline)
            }
        }
}

#Preview {
    VOsDetailsView(bin_id: "1091233", date: "Tue, 10 Oct 2023 14:14:25 GMT", status: true, vo: "LD123123")
}
