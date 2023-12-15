//
//  NOVsDetailView.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/16/23.
//

import SwiftUI

struct NOVsDetailView: View {
    @Environment(\.colorScheme) var colorScheme
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

                    GroupBox () {
                        HStack{
                            Label("\(nov)", systemImage: "signpost.right.and.left")
                                .font(.headline)
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Issued On:")
                                Spacer()
                                Text("\(getDateFromString(date))")
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.quaternary)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                Text("BIN:")
                                Spacer()
                                Text("\(bin_id)")
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.quaternary)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                Text("Status:")
                                Spacer()
                                Text("\(status ? "Active" : "Dismissed")")
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.quaternary)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                            Rectangle()
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(status ? Color("ActiveColor") : .purple)
                                .frame(height: 7)
                                .padding(.top)
                        }
                        .padding(.vertical)
                        .font(.subheadline)
                    }
                    .padding()
                    
                    Divider()
                    
                    // NOV Button
                    Button(action: {
                        if let url = URL(string: "https://fires.fdnycloud.org/CitizenAccess/Cap/CapDetail.aspx?Module=BFP&TabName=BFP&capID1=95F05&capID2=00000&capID3=0QPOW&agencyCode=FDNY&IsToShowInspection=") {
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
                        .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color(red: 240/255, green: 240/255, blue: 240/255))
                        .foregroundColor(Color.primary)
                        .cornerRadius(8)
                    }
                    .padding()

                    Spacer()
                }
                .navigationBarTitle("Viewing Notice of Violation", displayMode: .inline)
            }
        }
}

#Preview {
    NOVsDetailView(bin_id: "1091233", date: "Tue, 10 Oct 2023 14:14:25 GMT", status: true, nov: "014065990L")
}
