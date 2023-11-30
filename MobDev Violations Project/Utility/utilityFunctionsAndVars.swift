//
//  DateConverter.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/16/23.
//

import Foundation

let apiEndPoint = "https://b9de-2601-280-5c82-c970-7d43-334f-3331-94ad.ngrok-free.app"

func getDateFromString(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss 'GMT'"
    inputFormatter.timeZone = TimeZone(abbreviation: "GMT")

    guard let date = inputFormatter.date(from: dateString) else {
        return "2022-01-01"
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "yyyy-MM-dd" // or "dd MMM yyyy" for "10 Oct 2023"
    outputFormatter.timeZone = TimeZone(abbreviation: "GMT") // Set the timezone if needed
    
    return outputFormatter.string(from: date)
}
