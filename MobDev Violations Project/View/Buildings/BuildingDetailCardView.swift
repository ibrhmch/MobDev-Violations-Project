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
    @StateObject var viewModel = BuildingDetailsViewModel()
    @State var selectedFilterOption: Int = 0
    @State var alertsEnabled = false
    
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
            if !viewModel.buildingDetailsAreSet {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
            }
            else
            {
                VStack{
                    GroupBox() {
                        // Alerts HStack
                        HStack{
                            Label("Alerts \(!alertsEnabled ? "Disabled" : "Enabled")", systemImage: "bell.fill")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            //Enable Notifications Button
                            Button(action: {
                                alertsEnabled = !alertsEnabled
                            }) {
                                Image(systemName: !alertsEnabled ? "bell.slash.circle" : "bell.and.waveform.fill" )
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(7)
                                    .background(!alertsEnabled ? Color.purple : Color.green)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                            }
                        }
                        
                        //Get Directions HStack
                        HStack{
                            Label("\(building.address)", systemImage: "mappin.and.ellipse")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Button(action: {
                                let location = "\(building.address) NYC"
                                let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                if let url = URL(string: "http://maps.apple.com/?q=\(encodedLocation)") {
                                    if UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            }) {
                                
                                HStack{
                                    Image(systemName: "arrow.triangle.turn.up.right.circle")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(7)
                                        .background(.blue)
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        // Building Information
                        VStack() {
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
                            HStack {
                                Text("Active VOs:")
                                Spacer()
                                Text("\(viewModel.buildingDetails.violations.activeviolations)")
                            }
                            HStack {
                                Text("Active NOVs:")
                                Spacer()
                                Text("\(viewModel.buildingDetails.notices.activenotices)")
                            }
                        }
                        .font(.subheadline)
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
                    
                    FilterBar(selectedFilterOption: $selectedFilterOption)
                    
                    Divider()
                }
                .padding(.horizontal)

                
                ScrollView{
                    VStack(alignment: .center, spacing: 20) {
                        
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
        .task(priority: .userInitiated){
            viewModel.setBuilding(building.bin_id)
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
