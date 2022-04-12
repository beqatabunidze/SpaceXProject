//
//  LaunchesViewModel.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation

struct LaunchesViewModel {
    
    private var launch: Launch
    
    init(launch: Launch) {
        self.launch = launch
    }
    
    var flightNumber: Int {
        
        launch.flightNumber ?? 0
    }
    
    var name: String {
        launch.missionName ?? ""
    }
    
    var missionId: [String] {
        launch.missionId ?? [""]
    }
    
    var launchYear: String {
        launch.launchYear ?? ""
    }
    
    var links: Links {
        launch.links!
    }
    
    var patch: String {
        launch.links?.missionPatch ?? ""
    }
    
    var redditCampagne: String {
        launch.links?.redditCampaign ?? ""
    }
    
    var redditLaunch: String {
        launch.links?.redditLaunch ?? ""
    }
    
    var redditRecovery: String {
        launch.links?.redditRecovery ?? ""
    }
    
    var redditMedia: String {
        launch.links?.redditMedia ?? ""
    }
    
    var presskit: String {
        launch.links?.presskit ?? ""
    }
    
    var article: String {
        launch.links?.articleLink ?? ""
    }
    
    var wiki: String {
        launch.links?.wikipedia ?? ""
    }
    
    var video: String {
        launch.links?.videoLink ?? ""
    }
    
    var youtube: String {
        launch.links?.youtubeID ?? ""
    }
    
    var description: String {
        
        "\(launch.details?.prefix(50) ?? "Description is not available for this mission")"
    }
}
