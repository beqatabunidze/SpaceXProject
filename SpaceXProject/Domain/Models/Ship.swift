//
//  Ship.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation

// MARK: - Ship
struct Ship: Codable {
    let shipID, shipName: String?
    let shipType: String?
    let roles: [String]?
    let yearBuilt: Int?
    let homePort: String?
    let missions: [ShipMission]?
    let url: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case shipID = "ship_id"
        case shipName = "ship_name"
        case shipType = "ship_type"
        case roles
        case yearBuilt = "year_built"
        case homePort = "home_port"
        case missions, url, image
    }
}

// MARK: - Missions
struct ShipMission: Codable {
    let name: String?
    let flight: Int?
}

typealias ShipList = [Ship]
