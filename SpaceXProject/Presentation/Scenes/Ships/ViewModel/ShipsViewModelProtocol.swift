//
//  ShipsViewModelProtocol.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation
import UIKit

protocol ShipsViewModelProtocol: AnyObject {
    
    func getShipsList(completion: @escaping (([ShipsViewModel]) -> Void))
    var spinner: UIActivityIndicatorView? { get set }
    
    init(with shipsManager: FetchManagerProtocol)
}

class ShipsListViewModel: ShipsViewModelProtocol {

    var spinner: UIActivityIndicatorView?
    
    private var shipsManager: FetchManagerProtocol!
    
    required init(with shipsManager: FetchManagerProtocol)  {
        self.shipsManager = shipsManager
    }
    
    func getShipsList(completion: @escaping (([ShipsViewModel]) -> Void)) {
        
        self.spinner?.startAnimating()
        shipsManager.fetchShips { ships in
            DispatchQueue.main.async {
                let shipsViewModel = ships.map { ShipsViewModel(ship: $0) }
                completion(shipsViewModel)
                self.spinner?.stopAnimating()
            }
        }
    }

}
