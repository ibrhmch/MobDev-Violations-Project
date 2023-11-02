//
//  BuildingDetailCardView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import SwiftUI

struct BuildingDetailCardView: View {
    @State var buildingDetails: BuildingDetailsResponse
    var building: Building
    var buildingDetailVM = BuildingDetailsViewModel()
    
    init() {
        self.building = Building(bin_id: "1076262", address: "6th Avenue")
        self.buildingDetails = BuildingDetailsResponse()
    }
    
    init(_ building: Building, _ buildingDetails: BuildingDetailsResponse){
        self.building = building
        self.buildingDetails = buildingDetails
    }
    
    var body: some View {
        VStack{
            Text("\(building.bin_id)")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            ScrollView{
                VStack(alignment: .center, spacing: 20) {
                    
                    GroupBox(label: Label("Building Information", systemImage: "building.columns")) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Address: ")
                                Spacer()
                                Text("\(building.address)")
                            }
                            HStack {
                                Text("BIN: ")
                                Spacer()
                                Text("\(building.bin_id)")
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
                            Text("\(buildingDetails.violations.activeviolations)")
                        }
                        
                        HStack {
                            Text("# of Notice of Violations:")
                            Spacer()
                            Text("\(buildingDetails.notices.activenotices)")
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .cornerRadius(7)
                        .overlay(
                            VStack {
                                Text("List of 7 Violation Orders")
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 10)
                                    .padding(.top, 0)
                                ForEach(buildingDetails.listOfViolations!, id: \.self) { string in
                                    Text(string.vo.prefix(18))
                                }
                            }
                                .padding()
                        )
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
    BuildingDetailCardView()
}
