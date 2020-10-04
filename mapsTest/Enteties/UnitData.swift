//
//  UnitData.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 04.10.2020.
//

import Foundation

struct UnitData: Codable {
    let success: Bool
    let data: DataUnit
}

struct DataUnit: Codable {
    let name: String
    let position: Position
}
