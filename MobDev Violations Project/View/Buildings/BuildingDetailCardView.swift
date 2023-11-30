//
//  BuildingDetailCardView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import SwiftUI
import MapKit

struct BuildingDetailCardView: View {
    var building: Building
    @ObservedObject var viewModel = BuildingDetailsViewModel()
    @State var buildingDetails = BuildingDetailsResponse()
    @State var firstAppear: Bool = true
    @State var selectedFilterOption: Int = 1
    
    var filteredVOs: [ViolationOrder] {
        if (selectedFilterOption == 1) {
            return viewModel.buildingDetails.listOfViolations ?? []
        } else if (selectedFilterOption == 2) {
            return viewModel.buildingDetails.listOfViolations?.filter { vo in
                vo.status == false
            } ?? []
        } else if (selectedFilterOption == 0) {
            return viewModel.buildingDetails.listOfViolations?.filter { vo in
                vo.status == true
            } ?? []
        } else {
            return []
        }
    }
    
    var filteredNOVs: [NoticeOfViolations] {
        if (selectedFilterOption == 1) {
            return viewModel.buildingDetails.listOfNotices ?? []
        } else if (selectedFilterOption == 2) {
            return viewModel.buildingDetails.listOfNotices?.filter { nov in
                nov.status == false
            } ?? []
        } else if (selectedFilterOption == 0) {
            return viewModel.buildingDetails.listOfNotices?.filter { nov in
                nov.status == true
            } ?? []
        } else {
            return []
        }
    }
    
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
                        
                        //Open in Maps Button
                        // ------------------
                        Button(action: {
                            let location = "\(building.address) NYC"
                            let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            if let url = URL(string: "http://maps.apple.com/?q=\(encodedLocation)") {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }) {
                            Label("View in Maps", systemImage: "map.fill")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .cornerRadius(8)
                        
                        //Enable Notifications Button
                        // ------------------
                        Button(action: {
                            // Subscribe action
                        }) {
                            Text("Enable Notifications")
                        }
                        .buttonStyle(FilledButtonStyle())
                        // ------------------
                        
                        
                        //Number of active Vos and Novs
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
                        // -------------------
                        
                        Spacer()
                        
                        FilterBar(selectedFilterOption: $selectedFilterOption)
                        
                        GroupBox(label: Label("\(filteredVOs.count) Violations Found", systemImage: "signpost.left")) {
                            VStack(alignment: .leading) {
                                ForEach(filteredVOs, id: \.self) { vo in
                                    
                                    NavigationLink(destination:                                 VOsDetailsView(
                                            bin_id: building.bin_id,
                                            date: vo.date ?? "",
                                            status: vo.status,
                                            vo: vo.vo)){
                                                HStack{
                                                    Text(vo.vo.prefix(23))
                                                        .font(.subheadline)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding()
                                                    
                                                    Spacer()
                                                    
                                                    Label("", systemImage: "hand.tap")
                                                }
                                                .background(.bar)
                                                .foregroundColor(.black)
                                                .cornerRadius(6.0)
                                                
                                            }
                                    
                                    Divider()
                                        .padding(.vertical, 5)
                                }
                            }
                            .padding()
                        }
                        .groupBoxStyle(DefaultGroupBoxStyle())
                        
                        GroupBox(label: Label("\(filteredNOVs.count) Notices Found", systemImage: "signpost.right")) {
                            VStack(alignment: .leading) {
                                ForEach(filteredNOVs, id: \.self) { nov in
                                    
                                    NavigationLink(destination:                                 NOVsDetailView(
                                            bin_id: building.bin_id,
                                            date: nov.date ?? "",
                                            status: nov.status,
                                            nov: nov.nov))
                                    {
                                        HStack{
                                            Text(nov.nov.prefix(23))
                                                .font(.subheadline)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
                                            
                                            Spacer()
                                            
                                            Label("", systemImage: "hand.tap")
                                        }
                                        .background(.bar)
                                        .foregroundColor(.black)
                                        .cornerRadius(6.0)
                                    }
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
            try? await Task.sleep(nanoseconds: 1_000_000_000)
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
