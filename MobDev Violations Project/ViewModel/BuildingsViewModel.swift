//
//  BuildingsViewModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import Foundation

@MainActor
class BuildingsViewModel: ObservableObject{
    @Published var buildingsFetched = false
    @Published var listOfBuildings: [Building]?
    
    func setBuildingByID(bin_id: String = "") async -> Building? {
        do {
            guard let url = URL(string: "http://127.0.0.1:5000/get_building?bin_id=\(bin_id)") else {
                print("Invalid URL")
                return nil
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid Response or Status Code not 200")
                return nil
            }
            
            let building = try JSONDecoder().decode(Building.self, from: data)
            return building
        } catch {
            print("Network Request or Decoding Failed: \(error)")
            return nil
        }
    }

    func setAllBuildings() async {
        do {
            guard let url = URL(string: "http://127.0.0.1:5000/get_all_buildings") else {
                print("Invalid URL")
                self.listOfBuildings = nil
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid Response or Status Code not 200")
                self.listOfBuildings = nil
                return
            }
            
            let buildings = try JSONDecoder().decode([Building].self, from: data)
            self.listOfBuildings = buildings
            self.buildingsFetched = true
        } catch {
            print("Network Request or Decoding Failed: \(error)")
            self.listOfBuildings = nil
        }
    }

}
