//
//  SessionData.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 04.10.2020.
//

import Foundation

struct SessionData: Codable {
    let success: Bool?
    let data: [DataSession]?
}

struct DataSession: Codable {
    let units: [Unit]?
}

// MARK: - Unit
struct Unit: Codable {
    let id: String?
    let checked, eye: Bool?
}
