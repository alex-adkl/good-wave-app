//
//  SurfSpotsModel.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation

struct SurfSpotsData: Codable {
    let records: [SurfSpotRecord]
}

struct SurfSpotRecord: Identifiable, Codable {
    let id: String
    let fields: SurfSpotFields
    let createdTime: String
}

struct SurfSpotFields: Codable {
    let photoURL: String
    let destination: String
    let destinationState: String
    let peakSeasonBegins: String
    let peakSeasonEnds: String
    let surfBreak: [String]
    let difficultyLevel: Int
    let peakSurfSeasonEnds: String
    let destinationStateCountry: String
    let forecastURL: String

    // Propriétés calculées (pas codées)
    var formattedPeakSeasonBegins: String {
        return formatDate(peakSeasonBegins)
    }

    var formattedPeakSeasonEnds: String {
        return formatDate(peakSeasonEnds)
    }

    private func formatDate(_ dateString: String) -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd"
        isoFormatter.locale = Locale(identifier: "en_US")

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "MMMM d"
        displayFormatter.locale = Locale(identifier: "en_US")

        if let date = isoFormatter.date(from: dateString) {
            return displayFormatter.string(from: date)
        }
        return dateString
    }

    enum CodingKeys: String, CodingKey {
        case photoURL = "photo_url"
        case destination
        case destinationState = "destination_state"
        case peakSeasonBegins = "peak_season_begins"
        case peakSeasonEnds = "peak_season_ends"
        case surfBreak = "surf_break"
        case difficultyLevel = "difficulty_level"
        case peakSurfSeasonEnds = "peak_surf_season_ends"
        case destinationStateCountry = "destination_state_country"
        case forecastURL = "Magic Seaweed Link"
    }
}

struct Photo: Codable {
    let id: String
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    let small: Thumbnail
    let large: Thumbnail
    let full: Thumbnail
}

struct Thumbnail: Codable {
    let url: String
    let width: Int
    let height: Int
}
