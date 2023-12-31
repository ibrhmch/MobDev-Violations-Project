//
//  BuildingDetailsViewModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/2/23.
//

import Foundation

class BuildingDetailsViewModel: ObservableObject {
    @Published var buildingDetails = BuildingDetailsResponse()
    @Published var buildingDetailsAreSet = false
    
    func setBuilding(_ bin_id: String) {
        Task{@MainActor in
            buildingDetails = await getBuildingByID(bin_id: bin_id) ?? BuildingDetailsResponse()
            buildingDetailsAreSet = true
        }
    }
    
    func getBuildingByID(bin_id: String) async -> BuildingDetailsResponse? {
        do {
            guard let url = URL(string: "\(apiEndPoint)/get_building_data?bin_id=\(bin_id)") else {
                print("Invalid URL")
                return nil
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid Response or Status Code not 200")
                return nil
            }
            
            let building = try JSONDecoder().decode(BuildingDetailsResponse.self, from: data)
            print("response received")
            return building
        } catch {
            print("Network Request or Decoding Failed: \(error)")
        }
        return nil
    }
}
