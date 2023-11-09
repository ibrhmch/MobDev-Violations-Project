//
//  BuildingDetailCardView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import SwiftUI

struct BuildingDetailCardView: View {
    @State var bin_id: String
    @State var address: String
    @ObservedObject var buildingDetailVM: BuildingDetailsViewModel
    
    init(_ bin_id: String, _ address: String){
        self.bin_id = bin_id
        self.address = address
        self.buildingDetailVM = BuildingDetailsViewModel(bin_id, address)
    }
    
    var body: some View {
        VStack{
            Text("\(buildingDetailVM.building.bin_id)")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            ScrollView{
                VStack(alignment: .center, spacing: 20) {
                    
                    GroupBox(label: Label("Building Information", systemImage: "building.columns")) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Address: ")
                                Spacer()
                                Text("\(buildingDetailVM.building.address)")
                            }
                            HStack {
                                Text("BIN: ")
                                Spacer()
                                Text("\(buildingDetailVM.building.bin_id)")
                            }
                            HStack {
                                Text("Block: ")
                                Spacer()
                                Text("static")
                            }
                        }
                        .padding()
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
                    
                    Button(action: {
                        // To be added later
                    }) {
                        Label("View in Maps", systemImage: "map.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(8)
                    Button(action: {
                        // Subscribe action
                    }) {
                        Text("Enable Notifications")
                    }
                    .buttonStyle(FilledButtonStyle())
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("# of Violation Orders:")
                            Spacer()
                            Text("\(buildingDetailVM.buildingDetails.violations.activeviolations)")
                        }
                        
                        HStack {
                            Text("# of Notice of Violations:")
                            Spacer()
                            Text("\(buildingDetailVM.buildingDetails.notices.activenotices)")
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    GroupBox(label: Label("\(buildingDetailVM.buildingDetails.violations.activeviolations) Violations Found", systemImage: "signpost.left")) {
                        VStack(alignment: .leading) {
                            ForEach(buildingDetailVM.buildingDetails.listOfViolations!, id: \.self) { string in
                                Label(string.vo.prefix(12), systemImage: "hand.tap")
                                    .frame(width: 200)
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 5)
                                    .background(Color(red: 151/255, green: 171/255, blue: 179/255))
                                    .cornerRadius(4)
                            }
                        }
                        .padding()
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
                    
                    GroupBox(label: Label("\(buildingDetailVM.buildingDetails.notices.activenotices) Notices Found", systemImage: "signpost.right")) {
                        VStack(alignment: .leading) {
                            ForEach(buildingDetailVM.buildingDetails.listOfViolations!, id: \.self) { string in
                                Label(string.vo.prefix(12), systemImage: "hand.tap")
                                    .frame(width: 200)
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 5)
                                    .background(Color(red: 151/255, green: 171/255, blue: 179/255))
                                    .cornerRadius(4)
                            }
                        }
                        .padding()
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())

                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            Task{
                await buildingDetailVM.buildingDetails = buildingDetailVM.getBuildingByID(bin_id: self.bin_id) ?? BuildingDetailsResponse()
            }
        }
    }
}

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    BuildingDetailCardView("1076262", "BOGUS ADDRESS")
}
