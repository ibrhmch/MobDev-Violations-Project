//
//  SettingsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct SettingsTabView: View {
    @State var isExpanded = false
    @State var notificationsOn = false
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State var barVerticalPadding: CGFloat = 10
    @AppStorage("DEFAULT_FILTER_OPTION") var defaultFilterOption: Int = 0
    @State var selectedFilterOption: Int = 0
    var tempListOfBuildings = ["1076262", "1023455", "1231454"]
//    @AppStorage("SUBSCRIBED_BUILDINGS_LIST") var listOfSubscribedBuildings: [String: Bool] = ["BOGUS BUILDING": false]
    
    // Dictionary to load the alertsStatuses of all the buildings
    @State var listOfBinAlertsStatus: [String: Bool] = ["Default": false]
    
    init() {
        _selectedFilterOption = State(initialValue: defaultFilterOption)
    }

    var body: some View {
        NavigationStack{
            VStack{
                ScrollView {
                    HStack{
                        Toggle("Notification Alerts",
                                isOn: $notificationsOn)
                        .padding(.horizontal)
                        .padding(.vertical, barVerticalPadding)
                        .background(.fill)
                        .cornerRadius(5)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    .padding(.horizontal)
                    
                    // Subscribed Buildings List
                    HStack{
                        VStack {
                            HStack{
                                Text("Subscribed Buildings")
                                Spacer()
                                Image(systemName: !isExpanded ? "rectangle.expand.vertical" : "rectangle.compress.vertical")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(.fill)
                                    .foregroundColor(Color.primary)
                                    .cornerRadius(5)
                            }
                            if isExpanded {
                                ScrollView{
                                    ForEach(Array(listOfBinAlertsStatus.keys), id:\.self){key in
                                        HStack{
                                            Text("\(key)")
                                            
                                            Spacer()
                                            
                                            //Enable Notifications Button
                                            Button(action: {
                                                
                                            }) {
                                                Image(systemName: "bell.slash.circle")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .padding(7)
                                                    .background(Color.purple)
                                                    .clipShape(Circle())
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        
                                        Divider()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, barVerticalPadding)
                        .frame(maxWidth: .infinity)
                        .background(.fill)
                        .cornerRadius(5)
                        .transition(.move(edge: .trailing))
                        .onTapGesture {
                            withAnimation(
                                .easeOut(duration: 0.2)) {
                                    isExpanded.toggle()
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    .padding(.horizontal)
                    
                    HStack{
                        Toggle("Dark Mode",
                                isOn: $darkModeEnabled)
                        .padding(.horizontal)
                        .padding(.vertical, barVerticalPadding)
                        .background(.fill)
                        .cornerRadius(5)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    .padding(.horizontal)
                    
                    HStack{
                        VStack{
                            Text("Default Violations Filter")
                                .padding(.vertical)
                            FilterBar(selectedFilterOption: $selectedFilterOption)
                            .onChange(of:  selectedFilterOption){
                                defaultFilterOption = selectedFilterOption
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, barVerticalPadding)
                        .background(.fill)
                        .cornerRadius(5)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .font(.subheadline)
            .padding(.top, 30)
            .onAppear(){
                let userDefaults = UserDefaults.standard
                if let storedListOfBinAlertsStatus = userDefaults.object(forKey: "listOfBinAlertsStatus") as? [String: Bool] {
                    listOfBinAlertsStatus = storedListOfBinAlertsStatus
                } else {
                    listOfBinAlertsStatus = [:]
                }
                print(listOfBinAlertsStatus)
            }
        }
    }
}

#Preview {
    SettingsTabView()
}
