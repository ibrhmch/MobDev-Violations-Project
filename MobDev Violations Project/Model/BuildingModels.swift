//
//  BuildingsSearchModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//
import Foundation

struct Building: Decodable, Hashable {
    let bin_id: String
    let address: String

    init(bin_id: String = UUID().uuidString, address: String = "Random Address \(Int.random(in: 1...1000))") {
        self.bin_id = bin_id
        self.address = address
    }
}

struct NumberOfNotices: Decodable, Hashable {
    let bin: String
    let date: String
    let activenotices: Int

    init(bin: String = UUID().uuidString, date: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none), activenotices: Int = Int.random(in: 1...10)) {
        self.bin = bin
        self.date = date
        self.activenotices = activenotices
    }
}

struct NumberOfViolations: Decodable, Hashable {
    let bin: String
    let date: String
    let activeviolations: Int

    init(bin: String = UUID().uuidString, date: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none), activeviolations: Int = Int.random(in: 1...10)) {
        self.bin = bin
        self.date = date
        self.activeviolations = activeviolations
    }
}

struct NoticeOfViolations: Decodable, Hashable {
    let bin: String
    let date: String?
    let nov: String
    let status: Bool

    init(bin: String = UUID().uuidString, date: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none), nov: String = UUID().uuidString, status: Bool = Bool.random()) {
        self.bin = bin
        self.date = date
        self.nov = nov
        self.status = status
    }
}

struct ViolationOrder: Decodable, Hashable {
    let bin: String
    let date: String?
    let status: Bool
    let vo: String

    init(bin: String = UUID().uuidString, date: String = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none), status: Bool = Bool.random(), vo: String = UUID().uuidString) {
        self.bin = bin
        self.date = date
        self.status = status
        self.vo = vo
    }
}

struct BuildingDetailsResponse: Decodable, Hashable {
    let violations: NumberOfViolations
    let notices: NumberOfNotices
    let listOfNotices: [NoticeOfViolations]?
    let listOfViolations: [ViolationOrder]?

    init() {
        self.violations = NumberOfViolations()
        self.notices = NumberOfNotices()
        self.listOfNotices = [NoticeOfViolations(), NoticeOfViolations(), NoticeOfViolations()]
        self.listOfViolations = [ViolationOrder(), ViolationOrder(), ViolationOrder()]
    }
}
