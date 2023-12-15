//
//  BuildingDetailCardView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import SwiftUI
import MapKit

struct BuildingDetailCardView: View {
    @AppStorage("HIDE_BUILDING_DETAILS") var HIDE_BUILDING_DETAILS = false
    @State var hideDetails = false
    @State var hideEveryThing = false
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = BuildingDetailsViewModel()
    @State var alertsEnabled = false
    @AppStorage("DEFAULT_FILTER_OPTION") var defaultFilterOption: Int = 0
    @State var selectedFilterOption: Int = 0
    
    // Dictionary to load the alertsStatuses of all the buildings
    @State var listOfBinAlertsStatus: [String: Bool] = ["Default": false]
    
    var building: Building
    
    init(_ bin_id: String, _ address: String){
        self.building = Building(bin_id: bin_id, address: address)
        _selectedFilterOption = State(initialValue: defaultFilterOption)
        _hideDetails = State(initialValue: HIDE_BUILDING_DETAILS)
    }
    
    // Function to persist the bin: alertsStatus data dictionary
    private func saveAlertsStatus(_ listOfBinAlertsStatus: [String: Bool]) {
        UserDefaults.standard.set(listOfBinAlertsStatus, forKey: "listOfBinAlertsStatus")
    }
    
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
    
    var body: some View {
        VStack{
            if !viewModel.buildingDetailsAreSet {
                    ProgressView("Loading Building Details")
                        .progressViewStyle(CircularProgressViewStyle())
            }
            else
            {
                if !hideDetails{
                    VStack{
                        if !hideEveryThing{
                            GroupBox() {
                                // Alerts HStack
                                HStack{
                                    Label("Alerts \(!alertsEnabled ? "Disabled" : "Enabled")", systemImage: "bell.fill")
                                        .font(.footnote)
                                        .padding(.horizontal, 7)
                                    
                                    Spacer()
                                    
                                    //Enable Notifications Button
                                    Button(action: {
                                        alertsEnabled = !alertsEnabled
                                        listOfBinAlertsStatus[building.bin_id] = alertsEnabled ? alertsEnabled : nil
                                        saveAlertsStatus(listOfBinAlertsStatus)
                                        print(listOfBinAlertsStatus)
                                    }) {
                                        HStack{
                                            Image(systemName: !alertsEnabled ? "bell.slash.circle" : "bell.and.waveform.fill" )
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .clipShape(Circle())
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 4)
                                        .background(!alertsEnabled ? Color.purple : Color(red: 61/255, green: 173/255, blue: 166/255))
                                        .cornerRadius(8)
                                    }
                                }
                                
                                //Get Directions HStack
                                HStack{
                                    Label("\(building.address)", systemImage: "mappin.and.ellipse")
                                        .font(.footnote)
                                        .padding(.horizontal, 7)
                                    
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
                                                .clipShape(Circle())
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 4)
                                        .background(.blue)
                                        .cornerRadius(8)
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
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 7)
                                    .background(.quaternary)
                                    .cornerRadius(3.0)
                                    
                                    HStack {
                                        Text("Block: ")
                                        Spacer()
                                        Text("static")
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 7)
                                    .background(.quaternary)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                    
                                    HStack {
                                        Text("Active Violations:")
                                        Spacer()
                                        Text("\(viewModel.buildingDetails.violations.activeviolations)")
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 7)
                                    .background(.quaternary)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                    
                                    HStack {
                                        Text("Active Notice of Violations:")
                                        Spacer()
                                        Text("\(viewModel.buildingDetails.notices.activenotices)")
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 7)
                                    .background(.quaternary)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                }
                                .font(.subheadline)
                            }
                            .groupBoxStyle(DefaultGroupBoxStyle())
                        }
                        
                        NotificationScheduleView(hideEveryThing: $hideEveryThing, bin_id: building.bin_id)
                        
                        Divider()
                    }
                    .padding(.horizontal)
                }
                
                if !hideEveryThing{
                    VStack{
                        HStack{
                            Image(systemName: hideDetails ? "arrow.down.to.line" : "arrow.up.to.line" )
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.fill)
                                .cornerRadius(5)
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation(
                                .bouncy(duration: 0.3)){
                                    hideDetails = !hideDetails
                                    HIDE_BUILDING_DETAILS = !HIDE_BUILDING_DETAILS
                                    if hideEveryThing && !hideDetails{
                                        hideEveryThing = hideDetails
                                    }
                                }
                        }
                        
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
                                                date: vo.date ?? "Date Not Found",
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
                                                    .background(.quaternary)
                                                    .foregroundColor(Color.primary)
                                                    .cornerRadius(6.0)
                                                    
                                                }
                                        
                                        Divider()
                                            .padding(.vertical, 5)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .groupBoxStyle(DefaultGroupBoxStyle())
                            
                            GroupBox(label: Label("\(filteredNOVs.count) Notices Found", systemImage: "signpost.right")) {
                                VStack(alignment: .leading) {
                                    ForEach(filteredNOVs, id: \.self) { nov in
                                        
                                        NavigationLink(destination:                                 NOVsDetailView(
                                                bin_id: building.bin_id,
                                                date: nov.date ?? "Date Not Found",
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
                                            .background(.quaternary)
                                            .foregroundColor(Color.primary)
                                            .cornerRadius(6.0)
                                        }
                                        Divider()
                                            .padding(.vertical, 5)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .groupBoxStyle(DefaultGroupBoxStyle())

                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            // Retrieve value from UserDefaults `listOfBinAlertsStatus` and initialize the State variable
            let userDefaults = UserDefaults.standard
            if let storedListOfBinAlertsStatus = userDefaults.object(forKey: "listOfBinAlertsStatus") as? [String: Bool] {
                listOfBinAlertsStatus = storedListOfBinAlertsStatus
            } else {
                listOfBinAlertsStatus = [:]
            }
            
            // Set alerts enabled = to saved value else default to false
            alertsEnabled = listOfBinAlertsStatus["\(building.bin_id)"] ?? false
            
            hideEveryThing = false
        }
        .task(priority: .userInitiated){
            //TODO remove this artificial delay
            try? await Task.sleep(nanoseconds: 1_500_000_000)
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
