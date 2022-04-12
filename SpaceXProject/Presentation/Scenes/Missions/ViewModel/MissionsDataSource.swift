//
//  MissionsDataSource.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation
import UIKit
import SafariServices

class MissionsDataSource: NSObject {
    
    // MARK: - private properties
    
    private var viewModel: LaunchesListViewModel!
    private var tableView: UITableView!
    private var launchesList = [LaunchesViewModel]()
    private var recivedMissionsList: [ShipMission] = []
    private var missionNames: [String?] = []
    private var filteredLaunchesList = [LaunchesViewModel]()
    private var viewController = UIViewController()
    private var searchedData = [LaunchesViewModel]()
    private var emptyMessage: String = "Please wait..."
    
    init(with tableView: UITableView, viewModel: LaunchesListViewModel, receivedMissionsList: [ShipMission], viewController: UIViewController) {
        super.init()
        
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel = viewModel
        self.recivedMissionsList = receivedMissionsList
        self.viewController = viewController
        
    }
    
    func refresh() {
        viewModel.getLaunchesList { launch in
            self.launchesList.append(contentsOf: launch)
            self.getMissionInformation()
            self.tableView.reloadData()
            self.emptyMessage = "There are no missions for this ship"
        }
    }
    
    func searched(with text: String) {
        
        if text == "" {
            
            searchedData = filteredLaunchesList
            
        } else {
            
            searchedData.removeAll()
            
            for mission in filteredLaunchesList {
                
                (mission.name.lowercased().contains(text.lowercased()) ? (searchedData.append(contentsOf: [mission])) : (emptyMessage = "I could not seem to find anything..."))
                
            }
            
        }
        
        self.tableView.reloadData()
    }
    
    func getMissionInformation() {
        
        for recivedMission in recivedMissionsList {
            missionNames.append(contentsOf: [recivedMission.name])
        }

        for missionName in missionNames {
            let filteredLaunch = launchesList.filter { $0.name == missionName }
            filteredLaunchesList.append(contentsOf: filteredLaunch)
            searchedData = filteredLaunchesList
            print(filteredLaunch, "filter")
        }
        
    }
    
    func getLinks(_ index: Int) {
        
        let alert = UIAlertController(title: "", message: "Choose a website below", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mission Patch", style: .default , handler:{ (UIAlertAction) in
            
            self.viewController.openSafari(self.filteredLaunchesList[index].patch)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Reddit Campagne", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].redditCampagne)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Reddit Launch", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].redditLaunch)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Reddit Media", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].redditMedia)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Reddit Recovery", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].redditRecovery)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Presskit", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].presskit)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Article", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].article)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Wikipedia", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].wiki)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Video", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari(self.filteredLaunchesList[index].video)
            
        }))
        
        alert.addAction(UIAlertAction(title: "YouTube", style: .default , handler:{ (UIAlertAction) in
            self.viewController.openSafari("https://www.youtube.com/watch?v=" + self.filteredLaunchesList[index].youtube)
            
        }))
        
        alert.addAction(UIAlertAction(title: "\("Cancel")", style: .cancel , handler:{ (UIAlertAction) in
            print("User click Approve button")
        }))
        
        viewController.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
}

// MARK: - tableView setup

extension MissionsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchedData.count != 0 ? searchedData.count : 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchedData.isEmpty {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            cell.emptyLabel.text = emptyMessage
            tableView.isScrollEnabled = false
            tableView.isUserInteractionEnabled = false
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MissionsTableViewCell") as! MissionsTableViewCell
            cell.configure(with: searchedData[indexPath.row])
            tableView.isUserInteractionEnabled = true
            tableView.isScrollEnabled = true
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        getLinks(indexPath.row)
    }
    
}

extension MissionsDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
}

