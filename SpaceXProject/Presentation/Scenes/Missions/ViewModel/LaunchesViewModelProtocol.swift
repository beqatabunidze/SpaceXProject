//
//  LaunchesViewModelProtocol.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation
import UIKit

protocol LaunchesViewModelProtocol: AnyObject {
    
    func getLaunchesList(completion: @escaping (([LaunchesViewModel]) -> Void))
    var spinner: UIActivityIndicatorView? { get set }
    
    init(with launchesManager: FetchManagerProtocol)
}

class LaunchesListViewModel: LaunchesViewModelProtocol {
    
    var spinner: UIActivityIndicatorView?
    
    private var launchesManager: FetchManagerProtocol!
    
    required init(with launchesManager: FetchManagerProtocol) {
        self.launchesManager = launchesManager
    }
    
    func getLaunchesList(completion: @escaping (([LaunchesViewModel]) -> Void)) {
        self.spinner?.startAnimating()
        launchesManager.fetchLaunches { launch in
            DispatchQueue.main.async {
                let launchViewModel = launch.map { LaunchesViewModel(launch: $0) }
                completion(launchViewModel)
                self.spinner?.stopAnimating()
            }
        }
    }
    
}
