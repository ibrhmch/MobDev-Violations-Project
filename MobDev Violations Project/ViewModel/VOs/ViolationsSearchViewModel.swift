//
//  ViolationsSearchViewModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/9/23.
//

import Foundation

@MainActor
class ViolationsSearchViewModel: ObservableObject {
    @Published var listOfViolations: [ViolationOrder]?
    @Published var violationsFetched: Bool = false
    
    
    func getAllViolations() async {
        do {
            guard let url = URL(string: "\(apiEndPoint)/get_all_violations") else {
                print("Invalid URL")
                self.listOfViolations = nil
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid Response or Status Code not 200")
                self.listOfViolations = nil
                return
            }
            
            let violationsList = try JSONDecoder().decode([ViolationOrder].self, from: data)
            self.listOfViolations = violationsList
            self.violationsFetched = true
        } catch {
            print("Network Request or Decoding Failed: \(error)")
            self.listOfViolations = nil
        }
    }
    
    
    
    func getSimilarViolations(_ vo: String) async {
        do {
            guard let url = URL(string: "http://127.0.0.1:5000/get_similar_violations?vo=\(vo)") else {
                print("Invalid URL")
                self.listOfViolations = nil
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid Response or Status Code not 200")
                self.listOfViolations = nil
                return
            }
            
            let violationsList = try JSONDecoder().decode([ViolationOrder].self, from: data)
            self.listOfViolations = violationsList
            self.violationsFetched = true
        } catch {
            print("Network Request or Decoding Failed: \(error)")
            self.listOfViolations = nil
        }
    }
}
