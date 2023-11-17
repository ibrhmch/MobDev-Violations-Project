//
//  BuildingsViewModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import Foundation

@MainActor
class BuildingsSearchViewModel: ObservableObject{
    @Published var buildingsFetched = false
    @Published var listOfBuildings: [Building]?

    func setAllBuildings() async {
        do {
            guard let url = URL(string: "https://d88a-2601-280-5c82-c970-11be-e5e6-dcb5-d028.ngrok-free.app/get_all_buildings") else {
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
