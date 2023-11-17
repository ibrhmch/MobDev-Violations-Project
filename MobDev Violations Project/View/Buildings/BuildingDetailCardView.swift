//
//  BuildingDetailCardView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import SwiftUI

struct BuildingDetailCardView: View {
    var building: Building
    @ObservedObject var viewModel = BuildingDetailsViewModel()
    @State var buildingDetails = BuildingDetailsResponse()
    @State var firstAppear: Bool = true
    
    init(_ bin_id: String, _ address: String){
        self.building = Building(bin_id: bin_id, address: address)
    }
    
    var body: some View {
        VStack{
            if firstAppear {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
            }
            else
            {
                Text("\(building.bin_id)")
                    .font(.subheadline)
                    .padding(.bottom, 20)
                
                ScrollView{
                    VStack(alignment: .center, spacing: 20) {
                        
                        GroupBox(label: Label("Building Information", systemImage: "building.columns")) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(building.address)")
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                Spacer()
                                Divider()
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
                                Text("# of Active VOs:")
                                Spacer()
                                Text("\(viewModel.buildingDetails.violations.activeviolations)")
                            }
                            
                            HStack {
                                Text("# of Active NOVs:")
                                Spacer()
                                Text("\(viewModel.buildingDetails.notices.activenotices)")
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        GroupBox(label: Label("\(viewModel.buildingDetails.listOfViolations!.count) Violations Found", systemImage: "signpost.left")) {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.buildingDetails.listOfViolations!, id: \.self) { vo in
                                    
                                    NavigationLink(destination:                                 VOsDetailsView(
                                            bin_id: building.bin_id,
                                            date: vo.date ?? "",
                                            status: vo.status,
                                            vo: vo.vo))
                                            {
                                        Label(vo.vo.prefix(23), systemImage: "hand.tap")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 10)
                                            .background(Color(red: 151/255, green: 171/255, blue: 179/255))
                                            .cornerRadius(7)
                                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                                        Divider()
                                            .padding(.vertical, 5)
                                    }
                                }
                            }
                            .padding()
                        }
                        .groupBoxStyle(DefaultGroupBoxStyle())
                        
                        GroupBox(label: Label("\(viewModel.buildingDetails.listOfNotices!.count) Notices Found", systemImage: "signpost.right")) {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.buildingDetails.listOfNotices!, id: \.self) { nov in
                                    Label(nov.nov.prefix(23), systemImage: "hand.tap")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 151/255, green: 171/255, blue: 179/255))
                                        .cornerRadius(7)
                                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                                    Divider()
                                        .padding(.vertical, 5)
                                }
                            }
                            .padding()
                        }
                        .groupBoxStyle(DefaultGroupBoxStyle())

                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task{
            viewModel.setBuilding(building.bin_id)
            buildingDetails = viewModel.buildingDetails
            firstAppear = false
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
    BuildingDetailCardView("1034198", "BOGUS ADDRESS")
}
