import UIKit
import Foundation

struct Building: Decodable, Hashable{
    let bin_id: String
    let address: String
}

struct NumberOfNotices: Decodable {
    let bin: String
    let date: String
    let activenotices: Int
}

struct NumberOfViolations: Decodable {
    let bin: String
    let date: String
    let activeviolations: Int
}

struct NoticeOfViolations: Decodable {
    let bin: String
    let date: String
    let nov: String
    let status: Bool
}

struct ViolationOrder: Decodable {
    let bin_id: String
    let date: String
    let status: Bool
    let vo: String
}

struct BuildingDetailsResponse: Decodable {
    let violations: NumberOfViolations
    let notices: NumberOfNotices
    let listOfNotices: [NoticeOfViolations]
    let listOfViolations: [ViolationOrder]
}
//
//// -------------------------------------------------
//
//func getBuildingByID(bin_id: String = "") async -> BuildingDetailsResponse? {
//    do {
//        guard let url = URL(string: "http://127.0.0.1:5000/get_building_data?bin_id=\(bin_id)") else {
//            print("Invalid URL")
//            return nil
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            print("Invalid Response or Status Code not 200")
//            return nil
//        }
//        
//        let building = try JSONDecoder().decode(BuildingDetailsResponse.self, from: data)
//        return building
//    } catch {
//        print("Network Request or Decoding Failed: \(error)")
//        return nil
//    }
//}
//
//Task {
//    await getBuildingByID(bin_id: "1023455")
//}
//
//func getSimilarViolations(_ vo: String) async -> [ViolationOrder]? {
//    do {
//        guard let url = URL(string: "http://127.0.0.1:5000/get_similar_violations?vo=\(vo)") else {
//            print("Invalid URL")
//            return nil
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            print("Invalid Response or Status Code not 200")
//            return nil
//        }
//        
//        let violationsList = try JSONDecoder().decode([ViolationOrder].self, from: data)
//        return violationsList
//    } catch {
//        print("Network Request or Decoding Failed: \(error)")
//        return nil    }
//}
//
//Task{
//    await getSimilarViolations("E639")
//}

let dateString = "Tue, 10 Oct 2023 14:14:25 GMT"

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss 'GMT'"
dateFormatter.timeZone = TimeZone(abbreviation: "GMT")

if let date = dateFormatter.date(from: dateString) {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "yyyy-MM-dd" // or "dd MMM yyyy" for "10 Oct 2023"
    outputFormatter.timeZone = TimeZone(abbreviation: "GMT") // Set the timezone if needed

    let dateOnlyString = outputFormatter.string(from: date)
    print(dateOnlyString) 
} else {
    print("There was an error converting the string into a date.")
}

