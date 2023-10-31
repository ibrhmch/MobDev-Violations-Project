//
//  BuildingsSearchModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/30/23.
//

import Foundation

struct Building: Decodable, Hashable{
    let bin_id: String
    let address: String
}
