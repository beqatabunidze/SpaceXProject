//
//  MissionsViewController.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import UIKit

class MissionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var dataSource: MissionsDataSource!
    private var viewModel: LaunchesViewModelProtocol!
    private var launchManager: FetchManagerProtocol!
    var receivedMissionsList: [ShipMission] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configureViewModel()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.refresh()
    }
    
    private func setupLayout() {
        
        searchBar.delegate = self
        tableView.register(UINib(nibName: "MissionsTableViewCell", bundle: nil), forCellReuseIdentifier: "MissionsTableViewCell")
        tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        
    }
    
    private func configureViewModel() {
        
        launchManager = FetchManager()
        viewModel = LaunchesListViewModel(with: launchManager)
        dataSource = MissionsDataSource(with: tableView, viewModel: viewModel as! LaunchesListViewModel, receivedMissionsList: receivedMissionsList, viewController: self)
        viewModel.spinner = self.spinner
        
    }
    
}

extension MissionsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.searched(with: searchText)
    }
}
