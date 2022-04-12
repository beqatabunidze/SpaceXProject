//
//  FetchManager.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

// URLs
enum SpaceXURL: String {
    case ship = "https://api.spacexdata.com/v3/ships"
    case launch = "https://api.spacexdata.com/v3/launches"
}

import Foundation

// FetchManagerProtocol creates skeleton definitions for fetching ships and launches

protocol FetchManagerProtocol: AnyObject {
    
    func fetchShips(completion: @escaping ((ShipList) -> Void))
    func fetchLaunches(completion: @escaping ((LaunchList) -> Void))
}

class FetchManager: FetchManagerProtocol {
    
    func fetchShips(completion: @escaping ((ShipList) -> Void)) {
        NetworkManager.shared.get(url: SpaceXURL.ship.rawValue) { (result: Result<ShipList, Error>) in
            switch result {
            case .success(let ships):
                completion(ships)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchLaunches(completion: @escaping ((LaunchList) -> Void)) {
        NetworkManager.shared.get(url: SpaceXURL.launch.rawValue) { (result: Result<LaunchList, Error>) in
            switch result {
            case .success(let launches):
                completion(launches)
            case .failure(let error):
                print(error)
            }
        }
    }
}
