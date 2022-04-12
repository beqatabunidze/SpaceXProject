//
//  ShipsViewModel.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation

struct ShipsViewModel {
    
    private var ship: Ship
    
    init(ship: Ship) {
        self.ship = ship
    }
    
    var name: String {
        (ship.shipName ?? "") + " " + (ship.shipType ?? "")
    }
    
    var port: String {
        ship.homePort ?? ""
    }
    
    var year: String {
        "\(ship.yearBuilt ?? 0000)"
    }
    
    var imageURL: URL? {
        
        URL(string: ship.image ?? "https://i.kym-cdn.com/entries/icons/original/000/027/100/_103330503_musk3.jpg")
    }
    
    var missionList: [ShipMission] {
        ship.missions!
    }

}
