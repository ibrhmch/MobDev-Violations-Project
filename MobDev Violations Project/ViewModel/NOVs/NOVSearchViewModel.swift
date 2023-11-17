//
//  NOVSearchViewModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/16/23.
//

import Foundation

@MainActor
class NOVSearchViewModel: ObservableObject {
    @Published var listOfNovs: [NoticeOfViolations]?
    @Published var NOVsFetched: Bool = false
    
    func getSimilarNOVs(_ nov: String) async {
        do {
            guard let url = URL(string: "https://61c3-2601-280-5c82-c970-e8a7-92e9-e75c-c02b.ngrok-free.app/get_similar_novs?nov=\(nov)") else {
                print("Invalid URL")
                self.listOfNovs = nil
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid Response or Status Code not 200")
                self.listOfNovs = nil
                return
            }
            
            let violationsList = try JSONDecoder().decode([NoticeOfViolations].self, from: data)
            self.listOfNovs = violationsList
            self.NOVsFetched = true
        } catch {
            print("Network Request or Decoding Failed: \(error)")
            self.listOfNovs = nil
        }
    }
}
