import UIKit

//struct Building: Decodable, Hashable{
//    let bin_id: String
//    let address: String
//}
//
//struct NumberOfNotices: Decodable {
//    let bin: String
//    let date: String
//    let activenotices: Int
//}
//
//struct NumberOfViolations: Decodable {
//    let bin: String
//    let date: String
//    let activeviolations: Int
//}
//
//struct NoticeOfViolations: Decodable {
//    let bin: String
//    let date: String
//    let nov: String
//    let status: Bool
//}
//
//struct ViolationOrder: Decodable {
//    let bin: String
//    let date: String
//    let status: Bool
//    let vo: String
//}
//
//struct BuildingDetailsResponse: Decodable {
//    let violations: NumberOfViolations
//    let notices: NumberOfNotices
//    let listOfNotices: [NoticeOfViolations]
//    let listOfViolations: [ViolationOrder]
//}
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
