//
//  Launch.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation

// MARK: - LaunchElement
struct Launch: Codable {
    let missionName: String?
    let launchYear: String?
    let links: Links?
    let details: String?
    let flightNumber: Int?
    let missionId: [String]?

    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case links, details
        case flightNumber = "flight_number"
        case missionId = "mission_id"
    }
}


// MARK: - Links
struct Links: Codable {
    let missionPatch, missionPatchSmall: String?
    let redditCampaign: String?
    let redditLaunch: String?
    let redditRecovery, redditMedia: String?
    let presskit: String?
    let articleLink: String?
    let wikipedia, videoLink: String?
    let youtubeID: String?
    let flickrImages: [String]?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
        case flickrImages = "flickr_images"
    }
}

typealias LaunchList = [Launch]
